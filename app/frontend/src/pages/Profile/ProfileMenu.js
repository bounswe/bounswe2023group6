import React from 'react';

const ProfileMenu = ({ activeTab, onTabChange }) => {
    const menuItems = [
        { label: 'Liked Posts', value: 'likedPosts' },
        { label: 'Liked Comments', value: 'likedComments' },
        { label: 'Created Posts', value: 'createdPosts' },
        { label: 'Rated Games', value: 'ratedGames' },
    ];

    return (
        <div className="flex w-full bg-gray-200 p-2 rounded mt-4 mb-8 shadow-xl">
            {menuItems.map((item) => (
                <button
                    key={item.value}
                    className={`flex-1 p-2 ${activeTab === item.value ? 'bg-cyan-700 text-gray-200 rounded shadow-xl' : 'bg-gray-200'
                        } hover:bg-cyan-700 hover:opacity-50 hover:text-gray-200`}
                    onClick={() => onTabChange(item.value)}
                >
                    {item.label}
                </button>
            ))}
        </div>
    );
};

export default ProfileMenu;
