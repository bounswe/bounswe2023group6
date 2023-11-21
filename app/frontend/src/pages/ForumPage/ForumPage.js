import React from 'react';
import 'tailwindcss/tailwind.css';
import gamelounge from '../../gamelounge.png';
import Sidebar from '../../components/Sidebar';
import userlogo from './user.jpg';
import upvotelogo from './upvote.png';
import downvotelogo from './downvote.png';

const ForumPage = () => {
  const forumPosts = [
    {
      id: 1,
      user: 'TonySpark',
      content: 'Dota, LoL, and Smite seem intimidating to me since they have been out for years and Pokemon Unite doesnt seem appealing to me. I wait for suggestions.',
      createDate: 'October 15, 2023',
      tags: ['moba', 'lol'],
      upvotes: 4,
      downvotes: 1,
    },
    {
      id: 2,
      user: 'maggieaustin',
      content: 'What is your dream fortnite collaboration? Mine are horror icons like Jason , Freddy , Michael Myers, Leatherface et. What are your ideas?',
      createDate: 'October 14, 2023',
      tags: ['fortnite', 'horror'],
      upvotes: 8,
      downvotes: 0,
    },
    {
      id: 3,
      user: 'johhnyy_may',
      content: 'I recently started dating someone obsessed with chess. I have never played it before and know nothing. What is the best way to learn chess?',
      createDate: 'October 12, 2023',
      tags: ['chess', 'boardgames'],
      upvotes: 10,
      downvotes: 2,
    },
    {
      id: 4,
      user: 'gamelover',
      content: 'I\'m new to the gaming world and looking for a fun multiplayer game to start with. Any recommendations?',
      createDate: 'October 12, 2023',
      tags: ['gaming', 'multiplayer'],
      upvotes: 8,
      downvotes: 1,
    },
    {
      id: 5,
      user: 'TechEnthusiast',
      content: 'Thinking of building a new gaming PC. What are the must-have components for a great gaming experience?',
      createDate: 'October 11, 2023',
      tags: ['gaming', 'pcbuild'],
      upvotes: 12,
      downvotes: 3,
    },
    {
      id: 6,
      user: 'nancy0',
      content: 'Any good video game adaptations of books? I love reading and want to explore gaming based on my favorite novels.',
      createDate: 'October 10, 2023',
      tags: ['gaming', 'books'],
      upvotes: 15,
      downvotes: 4,
    },
  ];

  return (
    <>
      <div className='w-full flex flex-col'>
        <div className='flex justify-center items-center p-1 bg-black'>
          <img src={gamelounge} alt='Site Logo' className='h-24' />
        </div>
        <div className='flex flex-row grow bg-gray-100'>
          <div className='w-1/5 flex flex-col gap-4'>
            <Sidebar />
          </div>
          <div className='w-full flex justify-center p-4 bg-gray-300 pb-20'>
            <div className='w-5/6 flex flex-col'>
              <div className='w-full flex flex-row'>
                <div className='flex flex-col'>
                  {forumPosts.map((post) => (
                    <div key={post.id} className='card compact bg-gray-50 text-sky-800 shadow-xl m-2 p-4'>
                      <div className='flex-col'>
                        <div className='flex items-center justify-between border-b-2 border-gray-200'>
                          <div className='flex items-center'>
                            <div className="avatar pb-2">
                              <div className="w-8 h-8 items-center rounded-full">
                                <img src={userlogo} />
                              </div>
                              <div className='w-40 h-8 ml-2 text-[#B46060] font-bold'>{post.user}</div>
                            </div>
                          </div>
                          <div className='text-cyan-700 flex items-center'>
                            {post.createDate}
                             <label htmlFor="my_modal_6" className="btn-sm btn-outline bg-gray-500 p-1 ml-4 text-gray-200 items-center rounded">Report</label>
                             <input type="checkbox" id="my_modal_6" className="modal-toggle" />
                             <div className="modal" role="dialog">
                               <div className="modal-box bg-black">
                                 <h3 className="font-bold text-lg text-gray-200">Thanks!</h3>
                                 <p className="py-4 text-gray-200">We will process your report as soon as possible.</p>
                                 <div className="modal-action">
                                   <label htmlFor="my_modal_6" className="btn-sm text-gray-200">Close</label>
                                 </div>
                               </div>
                             </div>
                          </div>
                        </div>
                      </div>
                      <p className='text-gray-700 pb-2'>{post.content}</p>
                      <div className='flex flex-wrap border-b-2 border-gray-200 pb-2 opacity-75'>
                        {post.tags.map((tag, index) => (
                          <span key={index} className='badge badge-neutral mr-2'>
                            #{tag}
                          </span>



                        ))}
                      </div>
                      <div className='flex mt-2 items-center justify-end'>
                        <textarea
                          className='w-full h-8 border rounded drop-shadow-md p-1'
                          placeholder='Write a comment...'
                        />
                        <button className='bg-cyan-700 h-8 text-white px-2 ml-2 rounded hover:bg-cyan-900 opacity-75'>
                            Send
                          </button>
                        <button className='w-6 h-6 ml-12'>
                          <img src={upvotelogo} alt='Thumbs Up' />
                        </button>
                        <p className='text-black ml-1 mr-4'>{post.upvotes}</p>
                        <button className='w-6 h-6 ml-2'>
                          <img src={downvotelogo} alt='Thumbs Down' />
                        </button>
                        <p className='text-black ml-1 mr-4'>{post.downvotes}</p>
                      </div>
                    </div>
                  ))}
                </div>
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
