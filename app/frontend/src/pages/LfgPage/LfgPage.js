import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
// import { getAllPosts } from '../../services/postService';
import LfgCard from "./LfgCard";
import {getUserInfoBySessionId} from "../../services/userService";
import {getAllGroups} from "../../services/lfgService";
import CreateLfg from "./CreateLfg";

export default function LfgPage() {

    const [groups, setGroups] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
//    const [filteredPosts, setFilteredPosts] = useState([]);
    const [currentUser, setCurrentUser] = useState(null);



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

    useEffect(() => {
        const fetchGroups = async () => {
            setIsLoading(true);
            try {
                const response = await getAllGroups();
                setGroups(response.data);
                console.log(groups)
                console.log("ss")
            } catch (error) {
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };

        fetchGroups();
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
                                <CreateLfg />
                            </div>

                        </div>
                        <div className='w-full flex flex-row'>
                            <div className='w-full flex flex-col'>
                                {groups.map((group) => (
                                    <LfgCard key={group.lfgId} group={group} currentUser={currentUser}/>
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
