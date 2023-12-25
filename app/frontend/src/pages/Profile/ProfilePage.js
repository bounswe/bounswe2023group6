import LikedPosts from './LikedPosts';
import Navbarx from '../../components/navbar/Navbar';
import ProfileMenu from './ProfileMenu.js';
import { getUserInfoByUsername, getLikedPostsByUserId, getCreatedPostsByUserId, getLikedCommentsByUserId } from '../../services/userService';
import { React, useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import EditProfile from "./EditProfile";

const ProfilePage = () => {
    const { username } = useParams();
    const [activeTab, setActiveTab] = useState('likedPosts'); // Initial active tab
    const [user, setUser] = useState({});
    const [postData, setPostData] = useState([]);

    //useEffect(() => {
    //    const fetchUserInfo = async () => {
    //        const response = await getUserInfoBySessionId();
    //        setUser(response.data);
    //        console.log('55555555555555', user);
    //    };
    //
    //    const fetchPosts = async () => {
    //        let response;
    //        switch (activeTab) {
    //            case 'createdPosts':
    //                response = await getCreatedPosts();
    //                break;
    //            case 'likedComments':
    //                response = await getLikedComments();
    //                break;
    //            default:
    //                response = await getLikedPosts();
    //        }
    //        setPostData(response.data);
    //    };
    //
    //    fetchUserInfo();
    //    fetchPosts();
    //}, [username, act]);

    useEffect(() => {
        		const user = async () => {
        			try {
        				const response = await getUserInfoByUsername(username)
        				setUser(response.data);
        				console.log(response.data)
        				const user = response.data
        				fetchPosts(user);
        			} catch (error) {
                        console.error("Error fetching user information:", error.response.data);
        			} finally {
        				console.log(username)
        			}
        		};

        	    const fetchPosts = async (user) => {
                        let postResponse;
                        switch (activeTab) {
                            case 'createdPosts':
                                postResponse = await getCreatedPostsByUserId(user.userId);
                                break;
                            case 'likedComments':
                                postResponse = await getLikedCommentsByUserId(user.userId);
                                break;
                            default:
                                postResponse = await getLikedPostsByUserId(user.userId);
                        }
                        setPostData(postResponse.data);
                    };
                    user();
                }, [username, activeTab])


    return (
        <>
            <Navbarx></Navbarx>
            <div className='flex flex-row bg-gray-50 justify-center'>
                <div className='w-2/3'>
                    <div className='flex flex-col p-5 justify-center items-center'>
                        <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl'>
                            <div className='flex justify-center items-center w-1/5'>
                                <img src={user.profilePicture} className='rounded-full shadow-2xl' />
                            </div>
                            <div className='flex justify-end w-4/5'>
                            <h1 className='text-3xl text-[#b46161] mb-2'>{user.username}</h1>
                                <div className='flex justify-center'>
                                    <div className='card-actions flex justify-end items-end'>
                                        <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                            {user.title}
                                        </button>
                                        <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                            {user.company}
                                        </button>
                                    </div>
                                    <div className='card-actions flex justify-end items-end'>
                                        <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                            {42} following
                                        </button>
                                        <button className='btn bg-gray-50 hover:bg-gray-50 text-gray-700 border-0 shadow-xl'>
                                            {31415926535} followers
                                        </button>
                                    </div>
                                </div>
                                <div className='card-actions justify-end h-0.05 mb-0'>
                                    <EditProfile user={user}/>
                                </div>
                            </div>
                        </div>
                        <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-8 flex h-1/4 mb-2 rounded-xl mt-2 w-2/3'>
                            <h2 className='flex justify-center items-center text-xl mb-3 mr-3'>About Me</h2>
                            <p className='text-gray-700 ml-4'>{user.about}</p>
                        </div>
                        <ProfileMenu activeTab={activeTab} onTabChange={setActiveTab} className='w-full mt-4' />
                        {activeTab === 'likedPosts' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'likedComments' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'createdPosts' && (
                            <div className='compact text-cyan-800 bg-gray-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                    </div>
                </div>
            </div>
            <div className='bg-black text-white text-center p-8'>
                <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
            </div>
        </>
    );
};

export default ProfilePage;
