import React, { useState, useRef, useEffect } from 'react'
import ReportIcon from '@mui/icons-material/Report'
import EditPost from '../pages/ForumPage/EditPost'
import { deletePost } from '../services/postService'
import { useNavigate } from 'react-router-dom'
import { useParams } from 'react-router-dom'
import TextWithAnnotations from '../components/TextWithAnnotation'
import CloseIcon from '@mui/icons-material/Close'
import { createAnnotation, getAnnotationsByTarget } from '../services/AnnotationService'
import { v4 as uuidv4 } from 'uuid'

const PostCard = ({ post, currentUser, onUpvote, onDownvote }) => {
	const isCurrentUserCreator = currentUser && post.creatorUser.username === currentUser.username
	const navigate = useNavigate()
	const params = useParams()

	const [annotations, setAnnotations] = useState([])
	const [showAnnotationButton, setShowAnnotationButton] = useState(false)
	const [selectionRange, setSelectionRange] = useState({ startIndex: 0, endIndex: 0, value: '' })
	const [annotationText, setAnnotationText] = useState('')
	const [showAnnotationPopup, setShowAnnotationPopup] = useState(false)
	const postContentRef = useRef()

	useEffect(() => {
		const loadAnnotations = async () => {
			try {
				const response = await getAnnotationsByTarget(`http://167.99.242.175:8080/post/${post.postId}`)

				const transformedAnnotations = response.data.map((annotation) => ({
					startIndex: annotation.target.selector.start,
					endIndex: annotation.target.selector.end,
					value: annotation.body[0].value
				}))

				setAnnotations(transformedAnnotations)
			} catch (error) {
				console.error('Error loading annotations:', error)
			}
		}

		if (post) {
			loadAnnotations()
		}
	}, [post])

	const handleTextSelect = () => {
		const selection = window.getSelection()
		if (selection.rangeCount === 0) return

		const range = selection.getRangeAt(0)
		const preSelectionRange = range.cloneRange()
		preSelectionRange.selectNodeContents(postContentRef.current)
		preSelectionRange.setEnd(range.startContainer, range.startOffset)
		const startIndex = preSelectionRange.toString().length

		const endIndex = startIndex + range.toString().length

		if (range.toString().length > 0 && postContentRef.current.contains(range.startContainer)) {
			setSelectionRange({ startIndex, endIndex, value: range.toString() })
			setShowAnnotationButton(true)
		} else {
			setShowAnnotationButton(false)
		}
	}

	const handleAddAnnotationClick = () => {
		setShowAnnotationButton(false)
		setShowAnnotationPopup(true)
	}

	const handleClosePopup = () => {
		setShowAnnotationPopup(false)
		setAnnotationText('')
	}

	const handleSubmitAnnotation = async () => {
		const annotationUuid = uuidv4() // Generate UUID
		const username = localStorage.getItem('username') // Fetch username from local storage

		const annotationData = {
			context: 'http://www.w3.org/ns/anno.jsonld',
			id: annotationUuid, // Use generated UUID
			type: 'Annotation',
			motivation: ['commenting', 'annotating'],
			creator: `http://167.99.242.175:8080/user/${username}`, // Use fetched username
			created: new Date().toISOString(),
			body: [
				{
					id: annotationUuid, // Use same UUID for body ID
					type: 'TextualBody',
					value: annotationText,
					format: 'text/plain',
					language: 'en',
					purpose: 'commenting'
				}
			],
			target: {
				id: `http://167.99.242.175:8080/post/${post.postId}`,
				format: 'text/html',
				language: 'en',
				selector: {
					type: 'TextPositionSelector',
					start: selectionRange.startIndex,
					end: selectionRange.endIndex
				}
			}
		}

		try {
			await createAnnotation(annotationData)
			window.location.reload()
			// setAnnotations((prevAnnotations) => [...prevAnnotations, annotationData])
		} catch (error) {
			console.error('Error creating annotation:', error)
		} finally {
			setShowAnnotationPopup(false)
			setAnnotationText('')
		}
	}

	const handleDeletePost = async (postId) => {
		try {
			await deletePost(postId)
			navigate('/forum')
		} catch (error) {
			console.error('Error deleting post:', error)
		}
	}

	return (
		<div className='card compact bg-neutral-200 text-neutral-800 shadow-xl m-4 p-2'>
			<div className='absolute top-2 right-2 flex'>
				{isCurrentUserCreator && (
					<>
						<EditPost post={post} />
						{params.postId && (
							<button
								onClick={() => handleDeletePost(post.postId)}
								className='btn btn-sm bg-neutral-200 border-none hover:bg-neutral-300'
								title='Delete Post'
							>
								🗑️
							</button>
						)}
					</>
				)}
				{!isCurrentUserCreator && (
					<button className='p-2 text-black rounded'>
						<ReportIcon sx={{ color: '#404040' }} />
					</button>
				)}
			</div>
			<div>
				<h3 className='text-2xl font-bold text-[#b46161] hover:text-[#8c4646] p-2'>
					<a href={`/posts/${post.postId}`} className='no-underline link'>
						{post.title}
					</a>
				</h3>
				<div className='flex-col m-2' onMouseUp={handleTextSelect} ref={postContentRef}>
					<TextWithAnnotations text={post.content} annotations={annotations} />
				</div>
			</div>

			{showAnnotationButton && (
				<div className='fixed bottom-10 right-10'>
					<button className='btn btn-primary' onClick={handleAddAnnotationClick}>
						Add Annotation
					</button>
				</div>
			)}

			{showAnnotationPopup && (
				<div className='fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-white p-6 border rounded shadow-lg z-50 w-96'>
					<div className='absolute top-0 right-0 p-2 cursor-pointer' onClick={handleClosePopup}>
						<CloseIcon />
					</div>
					<div className='mb-2'>
						Selected Text: <strong>{selectionRange.value}</strong>
					</div>
					<div className='mb-2'>
						Start: {selectionRange.startIndex}, End: {selectionRange.endIndex}
					</div>
					<div>
						<input
							type='text'
							value={annotationText}
							onChange={(e) => setAnnotationText(e.target.value)}
							className='border p-2 w-full'
							placeholder='Enter annotation text'
						/>
					</div>
					<div className='mt-2'>
						<button onClick={handleSubmitAnnotation} className='btn btn-primary'>
							Submit
						</button>
					</div>
				</div>
			)}

			<div className='flex flex-row justify-end'>
				<div className='flex items-center absolute left-4'>
					<div className='avatar'>
						<div className='w-8 h-8 rounded-full'>
							<img src={post.creatorUser.profilePicture || '/default-user.jpg'} alt='User' />
						</div>
					</div>
					<div className='ml-2 text-[#B46060] hover:text-[#8c4646]'>
						<a href={`/users/${post.creatorUser.username}`} className='no-underline link font-bold'>
							{post.creatorUser.username}
						</a>
						<p className='text-neutral-600 text-xs'>{new Date(post.creationDate).toLocaleDateString()}</p>
					</div>
				</div>
				<div className='flex flex-row'>
					<button
						onClick={() => onUpvote(post.postId)}
						className='btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]'
					>
						<i className='i pi pi-thumbs-up' />
					</button>
					<p className='text-neutral-600 ml-1 mr-4'>{post.upvotes}</p>
					<button
						onClick={() => onDownvote(post.postId)}
						className='btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]'
					>
						<i className='i pi pi-thumbs-down' />
					</button>
					<p className='text-neutral-600 ml-1'>{post.downvotes}</p>
				</div>
			</div>
		</div>
	)
}

export default PostCard
