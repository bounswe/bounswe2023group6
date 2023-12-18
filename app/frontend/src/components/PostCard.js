import React from 'react';
// import userlogo from '../user.jpg';
import upvotelogo from '../upvote.png';
import downvotelogo from '../downvote.png';
import ReportIcon from "@mui/icons-material/Report";
import EditPost from '../pages/ForumPage/EditPost';

const PostCard = ({ post, onUpvote, onDownvote }) => (

  <div key={post.id} className='card compact bg-neutral-200 text-neutral-800 shadow-xl m-2 p-2'>
  <div className='absolute top-2 right-2 flex'>
          <EditPost post={post}/>
          <button className="p-2 text-black rounded ">
            <ReportIcon/>
          </button>
        </div>
    <div className='flex-col'>
      <h3 className="text-2xl font-bold text-[#b46161]">
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
      <div className='flex justify-between items-center'>
        <div className="flex items-center">
          <div className="avatar">
            <div className="w-8 h-8 rounded-full">
              <img src={post.creatorUser.profilePicture || '/default-user.jpg'} alt='User'/>
            </div>
          </div>
          <div className='ml-2 text-[#B46060] font-bold'><a href={`/users/${post.creatorUser.username}`} className="no-underline link">
               {post.creatorUser.username}
                </a>
          </div>
        </div>
        <div className='flex'>
        <div className='flex mr-2'>
              <p className='text-neutral-600'>{new Date(post.creationDate).toLocaleDateString()}</p>
                    {post.tags.map((tag, index) => (
                        <span className="inline-flex items-center rounded-md bg-neutral-50 px-2 py-1 text-xs font-medium text-neutral-600 ring-1 ring-inset ring-neutral-500/10 ml-1" key={index}>
                            #{tag.name}
                        </span>
                    ))}
                </div>
        <div className='inline-flex items-center rounded-md bg-neutral-500 px-2 py-1 text-xs font-medium text-neutral-50 ring-1 ring-inset ring-neutral-500/10 mr-4'>{post.category}</div>
        <div className='mr-8 text-neutral-600'><a href={`/posts/${post.postId}`} className="no-underline link">
                                                            {post.totalComments} Comments
                                                             </a></div>
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
