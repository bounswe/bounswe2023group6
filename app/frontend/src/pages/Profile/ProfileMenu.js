import React from 'react';

const ProfileMenu = ({ activeTab, onTabChange }) => {
    const menuItems = [
        { label: 'Liked Posts', value: 'likedPosts' },
        { label: 'Liked Comments', value: 'likedComments' },
        { label: 'Created Posts', value: 'createdPosts' },
    ];

    return (
        <div className="flex w-full bg-neutral-200 p-2 rounded m-4 mb-8 shadow-xl">
            {menuItems.map((item) => (
                <button
                    key={item.value}
                    className={`flex-1 p-2 ${
                        activeTab === item.value ? 'bg-cyan-700 text-neutral-200 rounded shadow-xl' : 'bg-neutral-200'
                    } hover:bg-cyan-700 hover:opacity-50 hover:text-neutral-200`}
                    onClick={() => onTabChange(item.value)}
                >
                    {item.label}
                </button>
            ))}
        </div>
    );
};

export default ProfileMenu;