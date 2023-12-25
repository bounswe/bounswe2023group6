import LikedPosts from './LikedPosts';
import Navbarx from '../../components/navbar/Navbar';
import ProfileMenu from './ProfileMenu.js';
import { getUserInfoByUsername, getLikedPostsByUserId, getCreatedPostsByUserId, getLikedCommentsByUserId, followUser, unfollowUser, getFollowings, getUserInfoBySessionId } from '../../services/userService';
import { React, useState, useEffect } from 'react';
import { useParams } from 'react-router-dom'
import EditProfile from "./EditProfile";
import profileIcon from "./profile.jpg";

const ProfilePage = () => {
    const { username } = useParams();
    const { sessionId } = useParams();
    const [activeTab, setActiveTab] = useState('likedPosts'); // Initial active tab
    const [user, setUser] = useState({});
    const [postData, setPostData] = useState([]);
    const [isFollowing, setIsFollowing] = useState(false);
    const [isCurrentUserProfile, setIsCurrentUserProfile] = useState(false);

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
        				const followingsResponse = await getFollowings();
                        const isFollowing = followingsResponse.data.some(user => user.userId === response.data.userId);
                        setIsFollowing(isFollowing)
                        const currentUserResponse = await getUserInfoBySessionId();
                        const currentUser = currentUserResponse.data;
                        const isCurrentUserProfile = user.userId === currentUser.userId;
                        setIsCurrentUserProfile(isCurrentUserProfile);

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


    const handleFollow = async () => {

    		if (!isFollowing) {
    			try {
    				await followUser(sessionId, user.userId);
    				setUser(prevUser => ({ ...prevUser, followerCount: prevUser.followerCount + 1 }));
    				setIsFollowing(true);
    				console.log(isFollowing);
    			} catch (error) {
    				console.error('Error following user:', error);
    			}
    		}
    	};

   const handleUnfollow = async () => {
       		if (isFollowing) {
       			try {
       				await unfollowUser(sessionId, user.userId);
       				setUser(prevUser => ({ ...prevUser, followerCount: prevUser.followerCount - 1 }));
       				setIsFollowing(false);
       			} catch (error) {
       				console.error('Error unfollowing user:', error);
       			}
       		}
       	};

    return (
        <>
            <Navbarx></Navbarx>
            <div className='flex flex-row bg-neutral-50 justify-center'>
                <div className='w-2/3'>
                    <div className='flex flex-col p-5 justify-center items-center'>
                        <div className='compact text-cyan-800 bg-neutral-200 shadow-xl p-4 flex h-1/4 mb-2 rounded-xl w-full'>
                            <div className='flex justify-center items-center w-1/5'>
                                <img src={user.profilePicture || profileIcon } className='rounded-full shadow-2xl' alt="Profile"
                                onError={(e) => {
                                e.target.src = profileIcon;
                                }}/>
                            </div>
                            <div className='flex justify-between w-4/5'>
                            <h1 className='text-3xl text-[#b46161] mb-2'>{user.username}</h1>
                                <div className='flex flex-col justify-center'>
                                 <div className='flex flex-row justify-center'>
                                <div className='card-actions flex justify-end items-end ml-2 mb-4'>
                                    {user.title && (
                                        <button className='btn bg-neutral-50 hover:bg-neutral-50 text-neutral-700 border-0 shadow-xl'>
                                            {user.title}
                                        </button>
                                    )}
                                    {user.company && (
                                        <button className='btn bg-neutral-50 hover:bg-neutral-50 text-neutral-700 border-0 shadow-xl'>
                                            {user.company}
                                        </button>
                                    )}
                                </div>
                                    </div>
                                    <div className='flex justify-end items-end ml-2 mb-4'>
                                        <button className='btn bg-neutral-50 hover:bg-neutral-50 text-neutral-700 border-0 shadow-xl mr-2'>
                                            {user.followingCount} following
                                        </button>
                                        <button className='btn bg-neutral-50 hover:bg-neutral-50 text-neutral-700 border-0 shadow-xl mr-2'>
                                            {user.followerCount} followers
                                        </button>
                                        {!isCurrentUserProfile && (
                                                            <>
                                                                {isFollowing ? (
                                                                    <button className='btn bg-neutral-500 hover:bg-neutral-600 text-neutral-100 border-0 shadow-xl' onClick={handleUnfollow}>
                                                                        Unfollow
                                                                    </button>
                                                                ) : (
                                                                    <button className='btn bg-neutral-500 hover.bg-neutral-600 text-neutral-100 border-0 shadow-xl' onClick={handleFollow}>
                                                                        Follow
                                                                    </button>
                                                                )}
                                                            </>
                                                        )}
                                                </div>
                                </div>
                                <div className='card-actions justify-end h-0.05 mb-0'>
                                    {isCurrentUserProfile && (
                                                        <EditProfile user={user} />
                                                    )}
                                </div>
                            </div>
                        </div>
                        <div className='compact text-cyan-800 bg-neutral-200 shadow-xl p-8 flex h-1/4 mb-2 rounded-xl mt-2 w-full'>
                            <h2 className='flex justify-center items-center text-xl mb-3 mr-3'>About Me</h2>
                            {user.about ? (
                                <p className='text-neutral-700 ml-4'>{user.about}</p>
                            ) : (
                                <p className='text-neutral-400 ml-4 font-style: italic'>There is no information yet</p>
                            )}
                        </div>
                        <ProfileMenu activeTab={activeTab} onTabChange={setActiveTab} className='w-full mt-4' />
                        {activeTab === 'likedPosts' && (
                            <div className='compact text-cyan-800 bg-neutral-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'likedComments' && (
                            <div className='compact text-cyan-800 bg-neutral-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
                                <div className='flex flex-col justify-center items-center w-full '>
                                    {postData.map((item, key) => (
                                        <LikedPosts item={item} key={key} />
                                    ))}
                                </div>
                            </div>
                        )}
                        {activeTab === 'createdPosts' && (
                            <div className='compact text-cyan-800 bg-neutral-200 shadow-xl p-4 flex w-full mb-2 rounded-xl'>
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