import React, { useState } from 'react';
import 'tailwindcss/tailwind.css';
import Navbarx from '../../components/navbar/Navbar';
import CreatePost from './CreatePost';
import PostCard from '../../components/PostCard';
import { getAllPosts } from '../../services/postService';
import { useEffect } from 'react';

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
  const [filteredPosts, setFilteredPosts] = useState([]);
  const [isLoading, setIsLoading] = useState(true);
  const [selectedCategory, setSelectedCategory] = useState('all');

  useEffect(() => {
    const fetchPosts = async () => {
      setIsLoading(true);
      try {
        const response = await getAllPosts();
        // setForumPosts(response.data);
        setForumPosts(response.data.sort((a, b) => a.postId - b.postId));
        setFilteredPosts(response.data.sort((a, b) => a.postId - b.postId));
      } catch (error) {
        console.error(error);
      } finally {
        setIsLoading(false);
      }
    };

    fetchPosts();
  }, []);

  const handleCategoryChange = (category) => {
    setSelectedCategory(category);
    if (category === 'all') {
      setFilteredPosts(forumPosts);
    } else {
      const filtered = forumPosts.filter((post) => post.category === category.toUpperCase());
      setFilteredPosts(filtered);
    }
  };


  if (isLoading) {
    return <div className='items-center justify-center flex'>Loading...</div>;
  }

  return (
    <>
      <Navbarx />
      <div className='w-full flex flex-col'>
        <div className='w-full flex justify-center p-4 bg-gray-50 pb-20'>
          <div className='w-3/6 flex flex-col'>
            <h1 className='text-4xl font-bold text-gray-700 text-center'>Forum</h1>
            <CreatePost />
            <div className='w-full flex flex-row'>
              <div className='w-full flex flex-col'>
                <div className='flex justify-center my-4'>
                  <button
                    className={`mx-2 px-4 py-2 rounded ${
                      selectedCategory === 'all' ? 'bg-blue-500 text-white' : 'bg-gray-300'
                    }`}
                    onClick={() => handleCategoryChange('all')}
                  >
                    All
                  </button>
                  <button
                    className={`mx-2 px-4 py-2 rounded ${
                      selectedCategory === 'discussion' ? 'bg-blue-500 text-white' : 'bg-gray-300'
                    }`}
                    onClick={() => handleCategoryChange('discussion')}
                  >
                    Discussion
                  </button>
                  <button
                    className={`mx-2 px-4 py-2 rounded ${
                      selectedCategory === 'review' ? 'bg-blue-500 text-white' : 'bg-gray-300'
                    }`}
                    onClick={() => handleCategoryChange('review')}
                  >
                    Review
                  </button>
                  <button
                    className={`mx-2 px-4 py-2 rounded ${
                      selectedCategory === 'guide' ? 'bg-blue-500 text-white' : 'bg-gray-300'
                    }`}
                    onClick={() => handleCategoryChange('guide')}
                  >
                    Guide
                  </button>
                </div>
                {filteredPosts.map((post) => (
                  <PostCard key={post.postId} post={post} />
                ))}
              </div>
            </div>
          </div>
        </div>
        <div className='bg-gray-400 text-white text-center p-8'>
          <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
        </div>
      </div>
    </>
  );
};

export default ForumPage;

