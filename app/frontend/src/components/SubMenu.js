import React from 'react';
import { Link } from 'react-router-dom';

const SubMenu = ({ item }) => {
    return (
        <Link to={item.path} onClick={item.action} className='flex items-center justify-center p-2 rounded-lg text-gray-700 hover:bg-blue-100 transition-colors cursor-pointer'>
            {item.icon}
            <span className='ml-2'>{item.label}</span>
        </Link>
    );
};

export default SubMenu;
