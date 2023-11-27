import React from 'react';
import 'tailwindcss/tailwind.css';
// import userlogo from '../../user.jpg';
// import upvotelogo from '../../upvote.png';
// import downvotelogo from '../../downvote.png';
import Navbarx from '../../components/navbar/Navbar';
import CreatePost from './CreatePost';
import PostCard from '../../components/PostCard';
import { getAllPosts } from '../../services/postService';
import { useState, useEffect } from 'react';

const ForumPage = () => {
  // const handleGetAllPosts = async () => {
  //   try {
  //     const response = await getAllPosts();
  //     console.log('HEY!', response.data);
  //     return response.data;
  //   } catch (error) {
  //     console.log(error);
  //   }
  // }

  const [forumPosts, setForumPosts] = useState([]);
  const [isLoading, setIsLoading] = useState(true);

  useEffect(() => {
    const fetchPosts = async () => {
      setIsLoading(true);
      try {
        const response = await getAllPosts();
        setForumPosts(response.data);
      } catch (error) {
        console.error(error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchPosts();
  }, []);

  if (isLoading) {
    return <div className='items-center justify-center flex'>Loading...</div>;
  }

  // const templateForumPosts = [
  //   {
  //     title: 'What is the best MOBA game for beginners?',
  //     id: 1,
  //     user: 'TonySpark',
  //     content: 'Dota, LoL, and Smite seem intimidating to me since they have been out for years and Pokemon Unite doesnt seem appealing to me. I wait for suggestions.',
  //     createDate: 'October 15, 2023',
  //     tags: ['moba', 'lol'],
  //     upvotes: 4,
  //     downvotes: 1,
  //     commentCount: 2,
  //   },
  //   {
  //     title: 'What is your dream fortnite collaboration?',
  //     id: 2,
  //     user: 'maggieaustin',
  //     content: 'What is your dream fortnite collaboration? Mine are horror icons like Jason , Freddy , Michael Myers, Leatherface et. What are your ideas?',
  //     createDate: 'October 14, 2023',
  //     tags: ['fortnite', 'horror'],
  //     upvotes: 8,
  //     downvotes: 0,
  //     commentCount: 3,
  //   },
  //   {
  //     title: 'What is the best way to learn chess?',
  //     id: 3,
  //     user: 'johhnyy_may',
  //     content: 'I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess?',
  //     createDate: 'October 12, 2023',
  //     tags: ['chess', 'boardgames'],
  //     upvotes: 10,
  //     downvotes: 2,
  //     commentCount: 1,
  //   },
  //   {
  //     title: 'What is the best multiplayer game for beginners?',
  //     id: 4,
  //     user: 'gamelover',
  //     content: 'I\'m new to the gaming world and looking for a fun multiplayer game to start with. Any recommendations?',
  //     createDate: 'October 12, 2023',
  //     tags: ['gaming', 'multiplayer'],
  //     upvotes: 8,
  //     downvotes: 1,
  //     commentCount: 0,
  //   },
  //   {
  //     title: 'What are the must-have components for a great gaming experience?',
  //     id: 5,
  //     user: 'TechEnthusiast',
  //     content: 'Thinking of building a new gaming PC. What are the must-have components for a great gaming experience?',
  //     createDate: 'October 11, 2023',
  //     tags: ['gaming', 'pcbuild'],
  //     upvotes: 12,
  //     downvotes: 3,
  //     commentCount: 0,
  //   },
  //   {
  //     title: 'Any good video game adaptations of books?',
  //     id: 6,
  //     user: 'nancy0',
  //     content: 'Any good video game adaptations of books? I love reading and want to explore gaming based on my favorite novels.',
  //     createDate: 'October 10, 2023',
  //     tags: ['gaming', 'books'],
  //     upvotes: 15,
  //     downvotes: 4,
  //     commentCount: 0,
  //   },
  // ];

  // const forumPosts = templateForumPosts.map((forumPost) => ({
  //   title: forumPost.title,
  //   content: forumPost.content,
  //   category: 'GUIDE', // Assuming all posts are of category 'GUIDE'
  //   postId: forumPost.id,
  //   creatorUserId: forumPost.user, // Assuming the 'user' field corresponds to 'creatorUserId'
  //   creationDate: new Date(forumPost.createDate).toISOString(),
  //   upvotes: forumPost.upvotes,
  //   downvotes: forumPost.downvotes,
  //   totalComments: forumPost.commentCount,
  // }));

  return (
    <>
      <Navbarx></Navbarx>
      <div className='w-full flex flex-col'>
        <div className='w-full flex justify-center p-4 bg-gray-50 pb-20'>
          <div className='w-3/6 flex flex-col'>
            <h1 className='text-4xl font-bold text-gray-700 text-center'>Forum</h1>
            <CreatePost/>
            <div className='w-full flex flex-row'>
              <div className='w-full flex flex-col'>
              {forumPosts.map((post) => (
                <PostCard key={post.postId} post={post} />
              ))}
              </div>
            </div>
          </div>
        </div>
        <div className="bg-gray-400 text-white text-center p-8">
          <p className="text-m">@2023 Game Lounge, All rights reserved.</p>
        </div>
      </div>
    </>
  );
};

export default ForumPage;
