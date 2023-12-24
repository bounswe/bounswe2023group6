import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import { getAllPosts } from '../../services/postService';
import LfgCard from "./LfgCard";
import {Button} from "@mui/material";

export default function LfgPage() {

    const [forumPosts, setForumPosts] = useState([]);
    const [isLoading, setIsLoading] = useState(true);

    const mockGroupData =
        {
            title: '"Looking for a co-op adventure in Hyrule!"',
            content: 'Need a skilled squad for high-intensity chicken dinners! Who\'s in for some PUBG action? Let\'s conquer the battleground together! 🍗🔫',
            tags: ['tag1', 'tag2'],
            playerNumber: 3
        }

    useEffect(() => {
        const fetchPosts = async () => {
            setIsLoading(true);
            try {
                const response = await getAllPosts();
                setForumPosts(response.data.sort((a, b) => a.postId - b.postId));
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

    return (
        <>
            <Navbarx />
            <div className='w-full flex flex-col'>
                <div className='w-full flex justify-center p-4 bg-neutral-100 pb-12'>

                    <div className='w-2/3 flex flex-col'>
                        <h1 className='text-4xl font-bold text-neutral-700 text-center'>Groups</h1>
                        <div className='h-18 w-full flex flex-row pt-2 center-items'>
                            <div className='flex flex-row h-full w-1/2 p-4'>
                                <Button variant='outlined'
                                        sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
                                    Post a Lfg
                                </Button>
                            </div>

                        </div>
                        <div className='w-full flex flex-row'>
                            <div className='w-full flex flex-col'>
                                {forumPosts.map((post) => (
                                    <LfgCard key={post.postId} post={post} tags={post.tags} category={post.category} mockGroupData={mockGroupData}/>
                                ))}
                            </div>
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
