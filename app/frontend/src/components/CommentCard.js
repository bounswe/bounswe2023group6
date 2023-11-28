import React from 'react';
import userlogo from '../user.jpg';
import upvotelogo from '../upvote.png';
import downvotelogo from '../downvote.png';
import ReportIcon from "@mui/icons-material/Report";

const CommentCard = ({ comment, onUpvote, onDownvote }) => (  
  <div key={comment.commentId} className='card compact bg-orange-200 text-sky-800 shadow-xl m-2 p-4'>
    <div className='flex-col'>
        <p className='text-gray-700 mb-4'>{comment.content}</p>
        <button className="p-2 text-black rounded absolute right-1 top-1">
          <ReportIcon />
        </button>
      <div className='flex justify-between items-center'>
        <div className="flex items-center">
          <div className="avatar">
            <div className="w-8 h-8 rounded-full">
              <img src={userlogo} alt='User'/>
            </div>
          </div>
          <div className='ml-2 text-[#B46060] font-bold'>{comment.creatorUserId}</div>
        </div>
        <div className='flex'>
        <button onClick={() => onUpvote(comment.commentId)} className='w-6 h-6'>
          <img src={upvotelogo} alt='Thumbs Up'/>
        </button>
        <p className='text-black ml-1 mr-4'>{comment.upvotes}</p>
        <button onClick={() => onDownvote(comment.commentId)} className='w-6 h-6'>
          <img src={downvotelogo} alt='Thumbs Down'/>
        </button>
        <p className='text-black ml-1'>{comment.downvotes}</p>
        </div>
      </div>
    </div>
  </div>
);

export default CommentCard;