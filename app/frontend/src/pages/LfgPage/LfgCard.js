import React, { useState, useEffect } from 'react';
import ReportIcon from "@mui/icons-material/Report";
import {Button} from "@mui/material";
import {useNavigate} from 'react-router-dom'
import {deleteLfg} from "../../services/lfgService";
import ClearIcon from '@mui/icons-material/Clear';
import EditLfg from './EditLfg'
import axios from 'axios'

const LfgCard = ({ group, currentUser }) =>  {

    const isCurrentUserCreator = currentUser && group.user.username === currentUser.username ? true : false
    const axiosInstance = axios.create({
        baseURL: `${process.env.REACT_APP_API_URL}`
    })

    const [isMember, setIsMember] = React.useState(true);

    const isUserGroupMember = async (user, group) => {
        try {
            const userId = user?.userId;
            const members = group?.members;

            if (!userId || !members) {
                return false;
            }

            const isMember = members.some(member => member.userId === userId);
            return isMember;
        } catch (error) {
            return false;
        }
    };

    useEffect(() => {
        const fetchIsMember = async () => {
            const result = await isUserGroupMember(currentUser, group);
            setIsMember(result);
        };

        fetchIsMember();
    }, [currentUser, group]);

    const [isGroupFull, setIsGroupFull] = useState(false);

    useEffect(() => {
        const checkGroupFullness = () => {
            setIsGroupFull(group.totalMembers === group.memberCapacity);
        };
        checkGroupFullness();
    }, [group.totalMembers, group.members.length]);

    const navigate = useNavigate()

    const joinGroup = async () => {
        console.log(group)
        console.log(isMember)
        axiosInstance.defaults.withCredentials = true;
        await axiosInstance.post(`/lfg/${group.lfgId}/join`,
            {
            withCredentials: true
            })
            .then((response) => {
                console.log(123)
                console.log(response);
                if (response.status === 200) {
                    setIsMember(true)
                    console.log("joined group successfully")
                }
                window.location.reload();
            })
            .catch((error) => {
                if (error.response) {
                    console.log("Error response from server:", error.response.data);
                } else if (error.request) {
                    console.log("No response received from server");
                } else {
                    console.log("Error during request setup:", error.message);
                }
            });
    };

    const leaveGroup = async () => {
        console.log(group)
        console.log(isMember)
        axiosInstance.defaults.withCredentials = true;
        await axiosInstance.post(`/lfg/${group.lfgId}/leave`,
            {
                withCredentials: true
            })
            .then((response) => {
                console.log(123)
                console.log(response);
                if (response.status === 200) {
                    setIsMember(false)
                    console.log("leaved group successfully")
                }
                window.location.reload();
            })
            .catch((error) => {
                if (error.response) {
                    console.log("Error response from server:", error.response.data);
                } else if (error.request) {
                    console.log("No response received from server");
                } else {
                    console.log("Error during request setup:", error.message);
                }
            });
    };
    const handleDeleteLfg = async (lfgId) => {
        try {
            await deleteLfg(lfgId)
            navigate('/groups')
            window.location.reload();
        } catch (error) {
            console.error('Error deleting lfg:', error)
        }
    }

    return (
        <div key={group.lfgId} className='card compact bg-neutral-200 text-neutral-800 shadow-xl m-2 p-2'>
            <div className='absolute top-2 right-2 flex'>
                {isCurrentUserCreator && (
                    <EditLfg lfg={group} />

                )}
                {isCurrentUserCreator && (
                    <button
                        onClick={() => {
                            const isConfirmed = window.confirm('Are you sure you want to delete the lfg?');
                            if (isConfirmed) {
                                handleDeleteLfg(group.lfgId);
                            }
                        }}
                        title='Delete Lfg'
                    >
                        <ClearIcon />
                    </button>
                )}
                {!isCurrentUserCreator && (
                    <button className="p-2 text-black rounded ">
                        <ReportIcon/>
                    </button>
                )}
            </div>
            <div className='flex-col'>
                <h3 className="text-2xl font-bold text-[#b46161]">
                    <a href={`/lfg/${group.lfgId}`} className="no-underline link">
                        {group.title}
                    </a>
                </h3>
                <p className='text-neutral-700 mb-4'>{group.description}</p>
                <div className='border-b-2 border-t-2 border-neutral-400 pb-3 mt-4 opacity-75 mb-4 md:grid md:grid-cols-3 md:gap-4'>
                    <div>
                        <p className='font-bold'>Platform: {group.requiredPlatform}</p>
                    </div>
                    <div>
                        <p className='font-bold'>Language: {group.requiredLanguage}</p>
                    </div>
                    <div>
                        <p className='font-bold'>Mic/Cam: {group.micCamRequirement ? "yes" : "no"}</p>
                        {false && <p className='font-bold'>Game: {group.relatedGame}</p>}
                    </div>
                </div>
                <div className='flex justify-between items-center'>
                    <div className="flex items-center">
                        <div className="avatar">
                            <div className="w-8 h-8 rounded-full">
                                <img src={group.user.profilePicture || '/default-user.jpg'} alt='User' />
                            </div>
                        </div>
                        <div className='ml-2 text-[#B46060] font-bold'>
                            <a href={`/users/${group.user.username}`} className='no-underline link'>
                                {group.user.username}
                            </a>
                        </div>
                    </div>
                    <div className='flex'>
                        <div className='flex mr-2'>
                            <p className='text-neutral-600'>{new Date(group.creationDate).toLocaleDateString()}</p>
                            {group.tags.map((tag, index) => (
                                <span
                                    className='inline-flex items-center rounded-md bg-neutral-50 px-2 py-1 text-xs font-medium text-neutral-600 ring-1 ring-inset ring-neutral-500/10 ml-1'
                                    key={index}
                                >
									#{tag.name}
								</span>
                        ))}
                    </div>
                    <div className='mr-8 text-neutral-600'>
                        {group.totalMembers}/{group.memberCapacity} Players
                    </div>
                    {!isMember && !isGroupFull && <Button variant='outlined' onClick={joinGroup}
                            sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
                        Join
                    </Button>}
                    {!isMember && isGroupFull && <Button variant='outlined'
                                                          sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
                        Full
                    </Button>}
                    {isMember && <Button variant='outlined' onClick={leaveGroup}
                                          sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
                        Leave
                    </Button>}
                </div>
            </div>
        </div>
    </div>
)};

export default LfgCard;
