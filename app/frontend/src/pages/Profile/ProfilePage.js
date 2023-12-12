import * as images from '../../pages/Auth/images';
import LikedPosts from './LikedPosts';
import Navbarx from '../../components/navbar/Navbar';
import GameCard from '../../components/navbar/GameCard';
import ProfileMenu from './ProfileMenu.js';
import { getUserInfoBySessionId, getLikedPosts, getCreatedPosts, getLikedComments, getRatedGames } from '../../services/userService';
import { React, useState, useEffect } from 'react';

const ProfilePage = () => {
    const temp_user = {
        name: 'Mahmut Demir',
        title: 'CEO',
        company: 'Peak Games',
        following: 144,
        followers: 123,
        about:
            'Greetings fellow gamers! As an avid player navigating the vast landscapes of virtual worlds, I find joy in the pixels and excitement in the ever-evolving narratives of video games. From intense battles in fantasy realms to strategic maneuvers in competitive arenas, gaming has become my digital sanctuary.',
    };

    const [activeTab, setActiveTab] = useState('likedPosts');
    const [, setUser] = useState({});
    const [postData, setPostData] = useState([]);

    useEffect(() => {
        const fetchUserInfo = async () => {
            const response = await getUserInfoBySessionId();
            setUser(response.data);
        };

        const fetchPosts = async () => {
            let response;
            switch (activeTab) {
                case 'createdPosts':
                    response = await getCreatedPosts();
                    break;
                case 'likedComments':
                    response = await getLikedComments();
                    break;
                case 'likedPosts':
                    response = await getLikedPosts();
                    break;
                default:
                    response = await getRatedGames();
                    break;
            }
            setPostData(response.data);
        };

        fetchUserInfo();
        fetchPosts();
    }, [activeTab]);

    return (
        <>
            <Navbarx></Navbarx>
            <div className='flex flex-row bg-gray-50 justify-center'>
                <div className='w-2/3'>
                    <div className='flex flex-col p-5 justify-center items-center'>
                        <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                            <div className='flex justify-center items-center w-1/5'>
                                <img src={images.mahmutdemir} className='rounded-full shadow-2xl' />
                            </div>
                            <div className='flex justify-end w-4/5'>
                                <div className='h-0.7'>
                                    <h1 className='text-3xl text-[#b46161] mb-2'>{temp_user.name}</h1>
                                    <span className='py-2 px-4 text-gray-700 rounded-2xl bg-gray-50 w-auto mr-3 mt-2 shadow-xl'>
                                        {"CEO"}
                                    </span>
                                    <span className='py-2 px-4 text-gray-700 rounded-2xl bg-gray-50 w-auto mt-2 shadow-xl'>
                                        {"EPIC GAMES"}
                                    </span>
                                </div>
                                <div className='card-actions flex justify-end items-end'>
                                    <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                        {42} following
                                    </button>
                                    <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                        {31415926535} followers
                                    </button>
                                </div>
                                <div className='card-actions justify-end h-0.05 mb-0'>
                                    <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                        <i className='i pi pi-user-edit' />
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-8 flex h-1/4 mb-2 rounded-xl mt-2'>
                            <h2 className='flex justify-center items-center text-xl mb-3 mr-3'>About Me</h2>
                            <p className='text-gray-700 ml-4'>{temp_user.about}</p>
                        </div>
                        <ProfileMenu activeTab={activeTab} onTabChange={setActiveTab} className='w-full mt-4' />
                        {activeTab === 'likedPosts' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'likedComments' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'createdPosts' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'ratedGames' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <GameCard item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
            <div className='bg-gray-400 text-white text-center p-8'>
                <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
            </div>
        </>
    );
};

export default ProfilePage;
