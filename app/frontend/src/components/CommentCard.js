import React from 'react'
import userlogo from '../user.jpg'
import ReportIcon from '@mui/icons-material/Report'
import DeleteIcon from '@mui/icons-material/Delete'
import { deleteComment } from '../services/commentService'

const CommentCard = ({ comment, onUpvote, onDownvote, currentUser }) => {
	const isCurrentUserCreator = comment.creatorUser.username === currentUser.username

	const handleDeleteComment = async (commentId) => {
		try {
			await deleteComment(commentId)
			window.location.reload()
		} catch (error) {
			console.error('Error deleting post:', error)
		}
	}

	return (
		<div key={comment.commentId} className='card compact bg-neutral-200 text-zinc-800 shadow-xl m-4 p-4'>
			<div className='flex-col'>
				<div className='flex flex-row mb-2'>
					<p className='text-zinc-700 m-2 mb-4 w-full'>{comment.content}</p>
					{isCurrentUserCreator ? (
						<button className='text-black rounded mb-4' onClick={() => handleDeleteComment(comment.commentId)}>
							<DeleteIcon sx={{ color: '#404040' }} />
						</button>
					) : (
						<button className='text-black rounded mb-4'>
							<ReportIcon sx={{ color: '#404040' }} />
						</button>
					)}
				</div>
				<div className='flex justify-between items-center'>
					<div className='flex items-center'>
						<div className='avatar'>
							<div className='w-8 h-8 rounded-full'>
								<img src={userlogo} alt='User' />
							</div>
						</div>
						<div className='ml-2 text-[#B46060] font-bold'>{comment.creatorUserId}</div>
					</div>
					<div className='flex'>
						<button
							onClick={() => onUpvote(comment.commentId)}
							className='btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]'
						>
							<i className='i pi pi-thumbs-up' />
						</button>
						<p className='text-black ml-1 mr-4'>{comment.upvotes}</p>
						<button
							onClick={() => onDownvote(comment.commentId)}
							className='btn btn-circle btn-sm bg-[#b46161] border-[#b46161] text-neutral-100 hover:bg-[#8c4646] hover:border-[#8c4646]'
						>
							<i className='i pi pi-thumbs-up' />
						</button>
						<p className='text-black ml-1'>{comment.downvotes}</p>
					</div>
				</div>
			</div>
		</div>
	)
}
export default CommentCard
