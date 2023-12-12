import React from 'react';
// import userlogo from '../user.jpg';
import upvotelogo from '../upvote.png';
import downvotelogo from '../downvote.png';
import ReportIcon from "@mui/icons-material/Report";
import EditPost from '../pages/ForumPage/EditPost';

const PostCard = ({ post, onUpvote, onDownvote }) => (
    <div key={post.id} className='card compact bg-gray-200 text-gray-800 shadow-xl m-2 p-4 relative'>
      <div className='absolute top-2 right-2 flex'>
        <EditPost post={post}/>
        <button className="p-2 text-black rounded ">
          <ReportIcon/>
        </button>
      </div>

      <div className='flex-col'>
        <h3 className="text-2xl font-bold text-[#b46161] link">
          <a href={`/posts/${post.postId}`}>{post.title}</a>
        </h3>
        <p className='text-gray-700 mb-4'>{post.content}</p>
        <div className='flex justify-between items-center'>
          <div className="flex items-center">
            <div className="avatar">
              <div className="w-8 h-8 rounded-full">
                <img src={post.creatorUser.profilePicture || '/default-user.jpg'} alt='User'/>
              </div>
            </div>
            <div className='ml-2 text-[#B46060] font-bold'>{post.creatorUser.username}</div>
          </div>
          <div className='flex'>
            <div className='mr-12'>{post.totalComments} Comments</div>
            <button onClick={() => onUpvote()} className='w-6 h-6'>
              <img src={upvotelogo} alt='Thumbs Up'/>
            </button>
            <p className='text-black ml-1 mr-4'>{post.upvotes}</p>
            <button onClick={() => onDownvote()} className='w-6 h-6'>
              <img src={downvotelogo} alt='Thumbs Down'/>
            </button>
            <p className='text-black ml-1'>{post.downvotes}</p>
          </div>
        </div>
      </div>
    </div>
);

export default PostCard;