import React from 'react';
import ReportIcon from "@mui/icons-material/Report";
import EditIcon from '@mui/icons-material/Edit'
import {Button} from "@mui/material";

const LfgCard = ({ post, mockGroupData }) =>  {



    return (
    <div key={post.id} className='card compact bg-neutral-200 text-neutral-800 shadow-xl m-2 p-2'>
        <div className='absolute top-2 right-2 flex'>
            <button className="p-2 text-black rounded ">
                <EditIcon/>
            </button>
            <button className="p-2 text-black rounded ">
                <ReportIcon/>
            </button>
        </div>
        <div className='flex-col'>
            <h3 className="text-2xl font-bold text-[#b46161]">
                <a href={`/posts/${post.postId}`} className="no-underline link">
                    {mockGroupData.title}
                </a>
            </h3>
            <p className='text-neutral-700 mb-4'>{mockGroupData.content}</p>
            <div className='flex flex-wrap border-b-2 border-neutral-400 pb-2 opacity-75 mb-4'>

            </div>
            <div className='flex justify-between items-center'>
                <div className="flex items-center">
                    <div className="avatar">
                        <div className="w-8 h-8 rounded-full">
                            <img src={post.creatorUser.profilePicture || '/default-user.jpg'} alt='User'/>
                        </div>
                    </div>
                    <div className='ml-2 text-[#B46060] font-bold'><a href={`/users/${post.creatorUser.username}`} className="no-underline link">
                        {post.creatorUser.username}
                    </a>
                    </div>
                </div>
                <div className='flex'>
                    <div className='flex mr-2'>
                        <p className='text-neutral-600'>{new Date(post.creationDate).toLocaleDateString()}</p>
                        {post.tags.map((tag, index) => (
                            <span className="inline-flex items-center rounded-md bg-neutral-50 px-2 py-1 text-xs font-medium text-neutral-600 ring-1 ring-inset ring-neutral-500/10 ml-1" key={index}>
                            #{tag.name}
                        </span>
                        ))}
                    </div>
                    <div className='inline-flex items-center rounded-md bg-neutral-500 px-2 py-1 text-xs font-medium text-neutral-50 ring-1 ring-inset ring-neutral-500/10 mr-4'>PC</div>
                    <div className='mr-8 text-neutral-600'>
                        2/3 Players
                    </div>
                    <Button variant='outlined'
                            sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
                        Join
                    </Button>
                </div>
            </div>
        </div>
    </div>
)};

export default LfgCard;
