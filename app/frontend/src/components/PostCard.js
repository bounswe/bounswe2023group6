import React from 'react'
import ReportIcon from '@mui/icons-material/Report'
import EditPost from '../pages/ForumPage/EditPost'
import { deletePost } from '../services/postService'
import { useNavigate } from 'react-router-dom'
import { useParams } from 'react-router-dom'

const PostCard = ({ post, currentUser, onUpvote, onDownvote }) => {
	const isCurrentUserCreator = currentUser && post.creatorUser.username === currentUser.username ? true : false
	const navigate = useNavigate()
	const params = useParams()

	const handleDeletePost = async (postId) => {
		try {
			await deletePost(postId)
			navigate('/forum')
		} catch (error) {
			console.error('Error deleting post:', error)
		}
	}

	return (
		<div key={post.postId} className='card compact bg-neutral-200 text-neutral-800 shadow-xl m-4 p-2'>
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
			<div className='flex-col m-4'>
				<h3 className="text-2xl font-bold text-[#b46161] hover:text-[#8c4646]">
					<a href={`/posts/${post.postId}`} className="no-underline link">
						{post.title}
					</a>
				</h3>
				<p className='text-neutral-700 mb-4'>{post.content}</p>
				<div className='flex flex-wrap border-b-2 border-neutral-400 pb-2 opacity-75 mb-4'>
					{/* {post.tags.map((tag) => (
            <span key={tag} className='badge badge-secondary mr-2'>#{tag}</span>
          ))} */}
				</div>
				<div className='flex flex-row justify-end'>
					<div className="flex items-center absolute left-4">
						<div className="avatar">
							<div className="w-8 h-8 rounded-full">
								<img src={post.creatorUser.profilePicture || '/default-user.jpg'} alt='User' />
							</div>
						</div>
						<div className='ml-2 text-[#B46060] hover:text-[#8c4646]'>
							<a href={`/users/${post.creatorUser.username}`} className="no-underline link font-bold">
								{post.creatorUser.username}
							</a>
							<p className='text-neutral-600 text-xs'>{new Date(post.creationDate).toLocaleDateString()}</p>
						</div>
					</div>
					<div className='flex justify-end'>
						<div className='hidden md:flex flex flex-wrap pb-2 opacity-75 mb-4 ml-48'>
							{post.tags.map((tag, index) => (
								<span key={index} className='rounded-md bg-neutral-50 px-1 mr-1 mb-1' style={{ whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }}>
									#{tag.name}
								</span>
							))}
						</div>
						<div className='hidden md:flex inline-flex btn-xs rounded-md bg-neutral-500 px-2 py-1 text-xs font-medium text-neutral-50 ring-1 ring-inset ring-neutral-500/10 mr-2'>
							{post.category}</div>
						<div className='hidden md:flex mr-2 ml-2 text-neutral-600 hover:text-neutral-900 link'>
							<a href={`/posts/${post.postId}`}>
								{post.totalComments} Comments
							</a>
						</div>
					</div>
					<div className='flex flex-row'>
						<button onClick={() => onUpvote(post.postId)} className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
							<i className="i pi pi-thumbs-up" />
						</button>
						<p className='text-neutral-600 ml-1 mr-4'>{post.upvotes}</p>
						<button onClick={() => onDownvote(post.postId)} className="btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]">
							<i className="i pi pi-thumbs-down" />
						</button>
						<p className='text-neutral-600 ml-1'>{post.downvotes}</p>
					</div>
				</div>
			</div>
		</div>
	);
};

export default PostCard;