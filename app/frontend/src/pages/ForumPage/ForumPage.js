import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import CreatePost from './CreatePost';
import PostCard from '../../components/PostCard';
import {getAllPosts, getAllTags} from '../../services/postService';
import SelectTags from './SelectTags';
import SortIcon from '@mui/icons-material/Sort';
import { upvotePost, downvotePost } from '../../services/postService';
import { getUserInfoBySessionId } from '../../services/userService';

export default function ForumPage() {
    const [forumPosts, setForumPosts] = useState([]);
    const [filteredPosts, setFilteredPosts] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const [selectedCategory, setSelectedCategory] = useState('all');
    const [selectedTags, setSelectedTags] = useState([]);
    const [tags, setTags] = useState([]);
    const [sortOrder, setSortOrder] = useState('asc');
    const [currentUser, setCurrentUser] = useState(null);

    const handleSortChange = () => {
        const newSortOrder = sortOrder === 'desc' ? 'asc' : 'desc';
        setSortOrder(newSortOrder);

        const sortedPosts = [...filteredPosts].sort((a, b) => {
            const dateA = new Date(a.createdAt).getTime();
            const dateB = new Date(b.createdAt).getTime();

            return newSortOrder === 'desc' ? dateB - dateA : dateA - dateB;
        });

        setFilteredPosts(sortedPosts);
    };

    const handleUpvote = async (postId) => {
        try {
          const response = await upvotePost(postId);
          setFilteredPosts((prevPosts) =>
            prevPosts.map((post) => (post.postId === postId ? response.data : post))
          );
        } catch (error) {
          console.error("Error upvoting post:", error);
        }
      };

      const handleDownvote = async (postId) => {
        try {
          const response = await downvotePost(postId);
          setFilteredPosts((prevPosts) =>
            prevPosts.map((post) => (post.postId === postId ? response.data : post))
          );
        } catch (error) {
          console.error("Error downvoting post:", error);
        }
      };

    useEffect(() => {
        const fetchPosts = async () => {
            setIsLoading(true);
            try {
                const response = await getAllPosts();
                setForumPosts(response.data.sort((a, b) => a.postId - b.postId));
                setFilteredPosts(response.data.sort((a, b) => a.postId - b.postId));
            } catch (error) {
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        const fetchTags = async () => {
            try {
                const response = await getAllTags();
                setTags(response.data)
                console.log(tags)
            } catch (error) {
                console.error(error);
            }
        }

        fetchPosts();
        fetchTags();
    }, []);

    useEffect(() => {
        const fetchUserInfo = async () => {
          try {
            const response = await getUserInfoBySessionId();
            const userData = response.data;
            setCurrentUser(userData);
            console.log('Current User:', userData);
          } catch (error) {
            console.error('Error fetching user info:', error);
          }
        };
        fetchUserInfo();
      }, []);

    const handleCategoryChange = (category) => {
      setSelectedCategory(category);

      if (category === 'all') {
        handleTagChange(selectedTags);
      } else {
        const filtered = forumPosts.filter((post) =>
          (selectedTags.length === 0 || post.tags.some((tag) => selectedTags.includes(tag.name))) &&
          post.category === category.toUpperCase()
        );
        setFilteredPosts(filtered);
      }
    };

    const handleTagChange = (value) => {
      setSelectedTags(value);
      const filtered = forumPosts.filter((post) =>
        (selectedCategory === 'all' || post.category === selectedCategory.toUpperCase()) &&
        (value.length === 0 || post.tags.some((tag) => value.includes(tag.name)))
      );

      setFilteredPosts(filtered);
    };

    if (isLoading) {
        return <div className='items-center justify-center flex'>Loading...</div>;
    }

    return (
        <>
            <Navbarx />
            <div className='w-full flex flex-col'>
                <div className='w-full flex justify-center p-4 bg-neutral-100 pb-12'>
                    <div className='hidden md:flex flex flex-col w-1/6'>
                    </div>
                    <div className='w-5/6 flex flex-col'>
                        <h1 className='text-4xl font-bold text-neutral-700 text-center'>Forum</h1>
                        <div className='h-18 w-full flex flex-row pt-2 center-items'>
                            <div className='flex flex-row h-full w-1/2 p-4'>
                                <CreatePost />
                            </div>
                            <div className='w-full h-1/2 flex justify-end px-2'>
                                            <div className='dropdown dropdown-end'>
                                                <div
                                                                tabIndex="0"
                                                                role="button"
                                                                className="btn bg-neutral-100 border-none hover:bg-neutral-100 hover:border-none text-neutral-600"
                                                                onClick={handleSortChange}
                                                            >
                                                                <SortIcon />
                                                            </div>
                                                <ul tabIndex="0" className="dropdown-content bg-neutral-800 text-neutral-200 z-[1] menu p-2 shadow rounded-box w-52">
                                                    <li><a onClick={handleSortChange}>Oldest</a></li>
                                                    <li><a onClick={handleSortChange}>Newest</a></li>
                                                </ul>
                                            </div>
                                        </div>
                        </div>
                        <div className='w-full flex flex-row'>
                            <div className='w-full flex flex-col'>
                                {filteredPosts.map((post) => (
                                    <PostCard key={post.postId}
                                              post={post}
                                              tags={post.tags}
                                              category={post.category}
                                              onUpvote={() => handleUpvote(post.postId)}
                                              onDownvote={() => handleDownvote(post.postId)}
                                              currentUser={currentUser}
                                             />
                                ))}
                            </div>
                        </div>
                    </div>
                    <div className='hidden md:flex w-1/6'>
                    <div className='flex flex-col h-full w-full py-8 px-1 rounded'>
                    <div className='flex flex-col justify-center my-2 space-y-2 mb-4'>
                                                                <h1 className='text-l text-neutral-900 text-center'>Select Categories</h1>
                                                        <button
                                                            className={`mx-2 px-4 py-2 rounded ${
                                                                selectedCategory === 'all' ? 'bg-cyan-600 text-white hover:bg-cyan-900' : 'bg-neutral-300 text-neutral-600 hover:text-white hover:bg-cyan-900'
                                                            }`}
                                                            onClick={() => handleCategoryChange('all')}
                                                        >
                                                            All
                                                        </button>
                                                        <button
                                                            className={`mx-2 px-4 py-2 rounded ${
                                                                selectedCategory === 'discussion' ?'bg-cyan-600 text-white hover:bg-cyan-900' : 'bg-neutral-300 text-neutral-600 hover:text-white hover:bg-cyan-900'
                                                            }`}
                                                            onClick={() => handleCategoryChange('discussion')}
                                                        >
                                                            Discussion
                                                        </button>
                                                        <button
                                                            className={`mx-2 px-4 py-2 rounded ${
                                                                selectedCategory === 'review' ?'bg-cyan-600 text-white hover:bg-cyan-900' : 'bg-neutral-300 text-neutral-600 hover:text-white hover:bg-cyan-900'
                                                            }`}
                                                            onClick={() => handleCategoryChange('review')}
                                                        >
                                                            Review
                                                        </button>
                                                        <button
                                                            className={`mx-2 px-4 py-2 rounded ${
                                                                selectedCategory === 'guide' ?'bg-cyan-600 text-white hover:bg-cyan-900' : 'bg-neutral-300 text-neutral-600 hover:text-white hover:bg-cyan-900'
                                                            }`}
                                                            onClick={() => handleCategoryChange('guide')}
                                                        >
                                                            Guide
                                                        </button>
                                                    </div>
                                                <SelectTags tags={tags}
                                                            selectedTags={selectedTags}
                                                            handleTagChange={handleTagChange} />
                                                </div>
                                                </div>
                </div>
                <div className='bg-black text-white text-center p-8'>
                    <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
                </div>
            </div>
        </>
    );
}
