import React from 'react';
import 'tailwindcss/tailwind.css';
// import userlogo from '../../user.jpg';
// import upvotelogo from '../../upvote.png';
// import downvotelogo from '../../downvote.png';
import Navbarx from '../../components/navbar/Navbar';
import PostCard from '../../components/PostCard';
import CommentCard from '../../components/CommentCard';


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
              </div>
            </div>
            <div className="bg-gray-400 text-white text-center p-8">
              <p className="text-m">@2023 Game Lounge, All rights reserved.</p>
            </div>
          </div>
        </>
      );
};
  
export default PostPage;