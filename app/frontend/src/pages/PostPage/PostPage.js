import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import PostCard from '../../components/PostCard';
import CommentCard from '../../components/CommentCard';
// import upvoteLogo from '../../upvote.png';
// import downvoteLogo from '../../downvote.png';
import { getPostById, upvotePost, downvotePost } from '../../services/postService';
import { useParams } from 'react-router-dom';
import { getAllCommentsForPost, createComment } from '../../services/commentService';


const PostPage = () => {
  const { postId } = useParams();
  console.log(postId);

  const [post, setPost] = useState(null);
  const [comments, setComments] = useState([]);

  // const comments = [
  //   {
  //     commentId: 1,
  //     creatorUserId: "alice123",
  //     content: "Chess is all about practice and strategy. Start by learning the basics.",
  //     creationDate: '2023-01-01T12:00:00.000Z',
  //     upvotes: 5,
  //     downvotes: 1,
  //   },
  // ];

  const handleUpvote = async () => {
    try {
      const response = await upvotePost(postId);
      setPost(response.data);
    } catch (error) {
      console.error("Error upvoting post:", error);
    }
  };

  const handleDownvote = async () => {
    try {
      const response = await downvotePost(postId);
      setPost(response.data);
    } catch (error) {
      console.error("Error downvoting post:", error);
    }
  };

  useEffect(() => {
    const fetchPostAndComments = async () => {
      try {
        const postResponse = await getPostById(postId);
        setPost(postResponse.data);
  
        const commentsResponse = await getAllCommentsForPost(postId);
        setComments(commentsResponse.data);
      } catch (error) {
        console.error("Error getting post and comments:", error);
      }
    };
  
    if (postId) {
      fetchPostAndComments();
    }
  }, [postId]);

  const [newComment, setNewComment] = useState('');

  const handleNewComment = async (e) => {
    e.preventDefault();
    try {
      const response = await createComment(postId, { content: newComment }, null);
      setComments([...comments, response.data]);
      setNewComment('');
    } catch (error) {
      console.error("Error creating comment:", error);
    }
  };

  return (
    <>  
      <Navbarx />
      <div className='w-full flex flex-col items-center'>
        <div className='w-3/4 flex flex-col p-4 bg-gray-50 pb-20'>
          {post && (
            <PostCard post={post} onUpvote={handleUpvote} onDownvote={handleDownvote} />
          )}
          <div className='mt-6'>
            {comments.map((comment) => (
              <CommentCard key={comment.commentId} comment={comment} />
            ))}
          </div>
          <textarea 
            className='w-full h-24 p-2 border-2 border-gray-300 rounded-lg shadow-md focus:outline-none focus:border-green-400' 
            placeholder='Add a comment...'
            value={newComment}
            onChange={(e) => setNewComment(e.target.value)}
          ></textarea>

          <button 
            className='w-20 h-10 p-2 bg-green-400 text-white rounded-lg shadow-md hover:bg-green-500 focus:outline-none'
            onClick={handleNewComment}
          >Send</button>
        </div>
      </div>
    </>
  );
};

export default PostPage;