import React from 'react';
import 'tailwindcss/tailwind.css';
// import userlogo from '../../user.jpg';
// import upvotelogo from '../../upvote.png';
// import downvotelogo from '../../downvote.png';
import Navbarx from '../../components/navbar/Navbar';
import PostCard from '../../components/PostCard';
import CommentCard from '../../components/CommentCard';
import { createPost } from '../../services/postService'; 



const post = {
  "title": "What is the best way to learn chess?",
  "content": "I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess?",
  "category": "GUIDE",
  "postId": 3,
  "creatorUserId": "johhnyy_may",
  "creationDate": "2023-10-11T21:00:00.000Z",
  "upvotes": 10,
  "downvotes": 2,
  "totalComments": 1
}
  
const comments = [
    {
        commentId: 0,
        creatorUserId: 0,
        content: "Although there's been different thoughts going back and forth about this, I've decided to continue in the current direction. It will work.",
        creationDate: '2023-11-26T22:15:24.604Z',
        upvotes: 0,
        downvotes: 0,
    },
    {
        commentId: 0,
        creatorUserId: 0,
        content: "Although there's been different thoughts going back and forth about this, I've decided to continue in the current direction. It will work.",
        creationDate: '2023-11-26T22:15:24.604Z',
        upvotes: 0,
        downvotes: 0,
    },
    {
        commentId: 0,
        creatorUserId: 0,
        content: "Although there's been different thoughts going back and forth about this, I've decided to continue in the current direction. It will work.",
        creationDate: '2023-11-26T22:15:24.604Z',
        upvotes: 0,
        downvotes: 0,
    },
];

const PostPage = () => {

  const handleCreatePost = async () => {
    try {
        const postData = {
            title: "New Post Title",
            content: "Content of the new post",
            category: "GUIDE"
        };
        const response = await createPost(postData);
        console.log(response);
    } catch (error) {
        console.error("Error creating post:", error);
    }
  };

    return (
        <>  
          <Navbarx></Navbarx>
          <div className='w-full flex flex-col'>
            <div className='w-full flex justify-center p-4 bg-gray-50 pb-20'>
              <div className='w-3/6 flex flex-col'>
                <h1 className='text-4xl font-bold text-gray-700 text-center'>Post Page</h1>
                <div className='w-full flex flex-row'>
                  <div className='flex flex-col'>
                    <PostCard post={post} />
                  </div>
                </div>
                {comments.map((comment) => (
                    <CommentCard key={comment.commentId} comment={comment} />
                ))}
                <div className='flex flex-row'>
                  <div className='flex flex-col w-5/6'>
                    <textarea className='w-full h-24 p-2 border-2 border-gray-300 rounded-lg shadow-md focus:outline-none focus:border-green-400' placeholder='Add a comment...'></textarea>
                  </div>
                  <div className='flex flex-col'>
                    <button className='w-20 h-10 p-2 bg-green-400 text-white rounded-lg shadow-md hover:bg-green-500 focus:outline-none'>Send</button>
                  </div>
                </div>
              </div>
            </div>
            <div className='flex justify-center mt-4'>
                  <button 
                    onClick={handleCreatePost}
                    className='px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 transition duration-300'
                  >
                    Create New Post
                  </button>
                </div>
            <div className="bg-gray-400 text-white text-center p-8">
              <p className="text-m">@2023 Game Lounge, All rights reserved.</p>
            </div>
          </div>
        </>
      );
};
  
export default PostPage;