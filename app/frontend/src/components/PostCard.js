import React from 'react';
// import userlogo from '../user.jpg';
import upvotelogo from '../upvote.png';
import downvotelogo from '../downvote.png';

const PostCard = ({ post }) => (  
  <div key={post.id} className='card compact bg-green-100 text-sky-800 shadow-xl m-2 p-4'>
    <div className='flex-col'>
      <h3 className="text-2xl font-bold text-gray-800 link">
          <a href={`/posts/${post.postId}`}>{post.title}</a>
      </h3>
      <p className='text-gray-700 mb-4'>{post.content}</p>
      <div className='flex flex-wrap border-b-2 border-gray-200 pb-2 opacity-75 mb-4'>
        {/* {post.tags.map((tag) => (
          <span key={tag} className='badge badge-secondary mr-2'>#{tag}</span>
        ))} */}
      </div>
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
          <div className='mr-12'>{post.totalComments} Comments </div>
          <button className='w-6 h-6'>
            <img src={upvotelogo} alt='Thumbs Up'/>
          </button>
          <p className='text-black ml-1 mr-4'>{post.upvotes}</p>
          <button className='w-6 h-6'>
            <img src={downvotelogo} alt='Thumbs Down'/>
          </button>
          <p className='text-black ml-1'>{post.downvotes}</p>
        </div>
      </div>
    </div>
  </div>
);

export default PostCard;