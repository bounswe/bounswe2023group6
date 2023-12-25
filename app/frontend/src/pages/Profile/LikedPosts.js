import React from 'react';

const LikedPosts = ({ item }) => {
    return (
        <div className="card bg-gray-50 text-cyan-800 shadow-xl m-2 w-full">
            <div className="card-body">
                <a href={`/posts/${item.postId}`} className="link font-bold">
                                                 {item.title}
                                               </a>
                <p className="text-gray-700">{item.content}</p>
                 <div className="flex items-center">
                             <div className="avatar">
                               <div className="w-8 h-8 rounded-full">
                                 <img src={item.creatorUser.profilePicture || '/default-user.jpg'} alt='User' />
                               </div>
                             </div>
                             <div className='ml-2 text-[#B46060] hover:text-[#8c4646]'>
                               <a href={`/users/${item.creatorUser.username}`} className="no-underline link font-bold">
                                 {item.creatorUser.username}
                               </a>
                               <p className='text-neutral-600 text-xs'>{new Date(item.creationDate).toLocaleDateString()}</p>
                             </div>
                           </div>
            </div>
        </div>
    );
}

export default LikedPosts;
