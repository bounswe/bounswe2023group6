import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { IoIosCreate, IoMdHome, IoIosInformationCircle } from 'react-icons/io';
import axios from 'axios';

const Sidebar = () => {
    const api_url = process.env.REACT_APP_API_URL;
    const navigate = useNavigate();
    const [username, setUsername] = useState('');
    const userImage = localStorage.getItem('userImage');
    const [isLoggedIn, setIsLoggedIn] = useState(false);

    useEffect(() => {
        const storedUsername = localStorage.getItem('username');
        if (storedUsername) {
            setUsername(storedUsername);
            setIsLoggedIn(true);
        }
    }, []);

    const handleLogout = async () => {
        const response = await axios.post(`${api_url}/logout`, {}, { headers: { 'Content-Type': 'application/json' } });
        if (response.status === 200) {
            localStorage.removeItem('username');
            setIsLoggedIn(false);
            navigate('/login');
        }
    };

    const SidebarData = [
        { label: 'My Profile', icon: <IoIosCreate />, path: '/profile' },
        { label: 'Account Settings', icon: <IoMdHome />, path: '/settings' },
        { label: 'Homepage', icon: <IoMdHome />, path: '/' },
        { label: 'Forum', icon: <IoMdHome />, path: '/forum' },
        { label: 'Groups', icon: <IoIosInformationCircle />, path: '/groups' },
        { label: 'Games', icon: <IoIosInformationCircle />, path: '/games' },
        isLoggedIn && { label: 'Logout', icon: <IoMdHome />, path: '/', action: handleLogout }
    ].filter(Boolean);

    return (
        <div className='h-full bg-white text-center shadow rounded-lg p-4 space-y-4'>
            <div className='py-4'>
                {userImage && <img src={`data:image/png;base64,${userImage}`} alt="Profile" className='w-20 h-20 rounded-full mx-auto' />}
                <h3 className='text-gray-800 font-semibold'>{username}</h3>
            </div>
            <nav className='space-y-2'>
                {SidebarData.map((item, index) => (
                    <Link to={item.path} onClick={item.action} key={index} className='flex items-center justify-center p-2 rounded-lg text-gray-700 hover:bg-blue-100 transition-colors cursor-pointer'>
                        {item.icon}
                        <span className='ml-2'>{item.label}</span>
                    </Link>
                ))}
            </nav>
        </div>
    );
};

export default Sidebar;
