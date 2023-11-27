import React from 'react';
import 'tailwindcss/tailwind.css';
import userlogo from './user.jpg';
import upvotelogo from './upvote.png';
import downvotelogo from './downvote.png';
import Navbarx from '../../components/navbar/Navbar';
import CreatePost from './CreatePost';

const ForumPage = () => {
  const forumPosts = [
    {
      title: 'What is the best MOBA game for beginners?',
      id: 1,
      user: 'TonySpark',
      content: 'Dota, LoL, and Smite seem intimidating to me since they have been out for years and Pokemon Unite doesnt seem appealing to me. I wait for suggestions.',
      createDate: 'October 15, 2023',
      tags: ['moba', 'lol'],
      upvotes: 4,
      downvotes: 1,
      commentCount: 2,
    },
    {
      title: 'What is your dream fortnite collaboration?',
      id: 2,
      user: 'maggieaustin',
      content: 'What is your dream fortnite collaboration? Mine are horror icons like Jason , Freddy , Michael Myers, Leatherface et. What are your ideas?',
      createDate: 'October 14, 2023',
      tags: ['fortnite', 'horror'],
      upvotes: 8,
      downvotes: 0,
      commentCount: 3,
    },
    {
      title: 'What is the best way to learn chess?',
      id: 3,
      user: 'johhnyy_may',
      content: 'I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess? I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess?',
      createDate: 'October 12, 2023',
      tags: ['chess', 'boardgames'],
      upvotes: 10,
      downvotes: 2,
      commentCount: 1,
    },
    {
      title: 'What is the best multiplayer game for beginners?',
      id: 4,
      user: 'gamelover',
      content: 'I\'m new to the gaming world and looking for a fun multiplayer game to start with. Any recommendations?',
      createDate: 'October 12, 2023',
      tags: ['gaming', 'multiplayer'],
      upvotes: 8,
      downvotes: 1,
      commentCount: 0,
    },
    {
      title: 'What are the must-have components for a great gaming experience?',
      id: 5,
      user: 'TechEnthusiast',
      content: 'Thinking of building a new gaming PC. What are the must-have components for a great gaming experience?',
      createDate: 'October 11, 2023',
      tags: ['gaming', 'pcbuild'],
      upvotes: 12,
      downvotes: 3,
      commentCount: 0,
    },
    {
      title: 'Any good video game adaptations of books?',
      id: 6,
      user: 'nancy0',
      content: 'Any good video game adaptations of books? I love reading and want to explore gaming based on my favorite novels.',
      createDate: 'October 10, 2023',
      tags: ['gaming', 'books'],
      upvotes: 15,
      downvotes: 4,
      commentCount: 0,
    },
  ];

  return (
    <>
      <Navbarx></Navbarx>
      <div className='w-full flex flex-col'>
        <div className='w-full flex justify-center p-4 bg-gray-50 pb-20'>
          <div className='w-4/6 flex flex-col'>
            <h1 className='text-4xl font-bold text-gray-700 text-center'>Forum</h1>
            <div className='w-full flex flex-row'>
              <div className='flex flex-col'>
                {forumPosts.map((post) => (
                  <div key={post.id} className='card compact bg-green-100 text-sky-800 shadow-xl m-2 p-4'>
                    <div className='flex-col'>
                      <h3 className="text-2xl font-bold text-gray-800">{post.title}</h3>
                      <p className='text-gray-700 mb-4'>{post.content}</p>
                      <div className='flex flex-wrap border-b-2 border-gray-200 pb-2 opacity-75 mb-4'>
                        {post.tags.map((tag, index) => (
                          <span key={index} className='badge badge-secondary mr-2'>#{tag}</span>
                        ))}
                      </div>
                      <div className='flex justify-between items-center'>
                        <div className="flex items-center">
                          <div className="avatar">
                            <div className="w-8 h-8 rounded-full">
                              <img src={userlogo} alt='User'/>
                            </div>
                          </div>
                          <div className='ml-2 text-[#B46060] font-bold'>{post.user}</div>
                        </div>
                        <div className='flex'>
                          <div className='mr-4'>{post.commentCount} Comments </div>
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
