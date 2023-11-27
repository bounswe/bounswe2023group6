import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import PostCard from '../../components/PostCard';
import CommentCard from '../../components/CommentCard';
import upvoteLogo from '../../upvote.png';
import downvoteLogo from '../../downvote.png';
import { getPostById, upvotePost, downvotePost } from '../../services/postService';
import { useParams } from 'react-router-dom';



const PostPage = () => {
  const { postId } = useParams();
  console.log(postId);
  const [post, setPost] = useState(null);
  // const [comments, setComments] = useState([
  //   {
  //     commentId: 1,
  //     creatorUserId: "alice123",
  //     content: "Chess is all about practice and strategy. Start by learning the basics.",
  //     creationDate: '2023-01-01T12:00:00.000Z',
  //     upvotes: 5,
  //     downvotes: 1,
  //   },
  // ]);

  const comments = [
    {
      commentId: 1,
      creatorUserId: "alice123",
      content: "Chess is all about practice and strategy. Start by learning the basics.",
      creationDate: '2023-01-01T12:00:00.000Z',
      upvotes: 5,
      downvotes: 1,
    },
  ];

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const response = await getPostById(postId);
        setPost(response.data); // Assuming response.data contains the post object
      } catch (error) {
        console.error("Error getting post:", error);
      }
    };

    if (postId) {
      fetchPost();
    }
  }, [postId]);

  const handleUpvote = async () => {
    try {
      const response = await upvotePost(postId);
      setPost(response.data); // Update the post data with the new upvote count
    } catch (error) {
      console.error("Error upvoting post:", error);
    }
  };

  const handleDownvote = async () => {
    try {
      const response = await downvotePost(postId);
      setPost(response.data); // Update the post data with the new downvote count
    } catch (error) {
      console.error("Error downvoting post:", error);
    }
  };

  return (
    <>  
      <Navbarx />
      <div className='w-full flex flex-col items-center'>
        <div className='w-3/4 flex flex-col p-4 bg-gray-50 pb-20'>
          {post && (
            <>
              <PostCard post={post} />
              <div className='flex justify-between mt-4'>
                <button onClick={handleUpvote}>
                  <img src={upvoteLogo} alt='Upvote' className='w-6 h-6'/>
                </button>
                <span>{post.upvotes}</span>
                <button onClick={handleDownvote}>
                  <img src={downvoteLogo} alt='Downvote' className='w-6 h-6'/>
                </button>
                <span>{post.downvotes}</span>
              </div>
            </>
          )}
          <div className='mt-6'>
            {comments.map((comment) => (
              <CommentCard key={comment.commentId} comment={comment} />
            ))}
          </div>
          <div className='flex flex-row mt-4'>
            <div className='flex flex-col w-5/6'>
              <textarea className='w-full h-24 p-2 border-2 border-gray-300 rounded-lg shadow-md focus:outline-none focus:border-green-400' placeholder='Add a comment...'></textarea>
            </div>
            <div className='flex flex-col'>
              <button className='w-20 h-10 p-2 bg-green-400 text-white rounded-lg shadow-md hover:bg-green-500 focus:outline-none'>Send</button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default PostPage;