import React from 'react';
import * as images from "../../pages/Auth/images";
import Sidebar from '../../components/Sidebar'
import LikedPosts from "./LikedPosts";

const ProfilePage = () => {

    const user = {
        name: 'Mahmut Demir',
        title: 'CEO',
        company: 'Peak Games',
        following: 144,
        followers: 123,
        about: 'Greetings fellow gamers! As an avid player navigating the vast landscapes of virtual worlds, I find joy in the pixels and excitement in the ever-evolving narratives of video games. From intense battles in fantasy realms to strategic maneuvers in competitive arenas, gaming has become my digital sanctuary.',
    };

    const postData = [
        {
            header: 'Resident Evil 4 Remake',
            content: "Looking for someone to join me in my Resident Evil 4 adventure! Let's team up and face the horrors together.️ #ResidentEvil4 #GamingBuddyWanted",
            date: '27.10.2023  00.00',
        },
        {
            header: 'Fifa',
            content: "FIFA is one of the most popular football simulation games developed by EA Sports. It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums.",
            date: '28.10.2023  02.02',
        },
        {
            header: 'The Witcher 3: Wild Hunt',
            content: "The Witcher 3 is an unforgettable gaming experience. Its open world, rich storytelling, and captivating characters make it a must-play RPG. If you love epic adventures, this one's a masterpiece.",
            date: '29.10.2023  06.42',
        },
    ];

    return (
        <div className='flex flex-row bg-[#FFF4E0]'>
            <div className='w-1/5 flex flex-col h-screen'>
                <Sidebar/>
            </div>
            <div className='w-4/5 flex flex-col p-5 justify-center items-center'>
                <div className="compact text-[#FFF4E0] bg-[#4D4D4D]  text-sky-800 shadow-xl  p-4 flex w-4/5 h-1/4 mb-2 rounded-xl">
                    <div className="w-1/3 flex justify-center items-center">
                        <img src={images.mahmutdemir} className="rounded-full h-3/5 w-3/5"/>
                    </div>
                    <div className="w-2/3">
                        <div className="card-actions justify-end h-0.05 mb-0">
                            <button className="btn  btn-sm bg-[#B46060] hover:bg-[#B46060] text-white border-0 ">
                                <i className="i pi pi-user-edit"/>
                            </button>
                        </div>
                        <div className="h-0.7">
                            <h1 className="text-3xl mb-2">{user.name}</h1>
                            <span className="py-2 px-4 text-[#4D4D4D] rounded-2xl bg-[#FFF4E0] w-auto mr-3 mt-2">
                                {user.title}
                            </span>
                            <span className="py-2 px-4 text-[#4D4D4D] rounded-2xl bg-[#FFF4E0] w-auto mt-2">
                                {user.company}
                            </span>
                        </div>
                        <div className="card-actions flex justify-end items-end">
                            <button className="btn bg-[#B46060] hover:bg-[#B46060] text-white border-0">
                                {user.following} following
                            </button>
                            <button className="btn bg-[#B46060] hover:bg-[#B46060] text-white border-0">
                                {user.followers} followers
                            </button>
                        </div>
                    </div>
                </div>
                <div className="compact text-[#FFF4E0] bg-[#4D4D4D] text-sky-800 shadow-xl  p-4  w-4/5  h-1/6 mb-2 rounded-xl">
                    <h2 className="flex justify-center text-xl mb-3">About Me</h2>
                    <p>{user.about}
                    </p>
                </div>
                <div className="compact text-[#FFF4E0] bg-[#4D4D4D] text-sky-800 shadow-xl  p-4  w-4/5 rounded-xl">
                    <h2 className="flex justify-center text-xl mb-3">Liked Posts</h2>
                    <div className='flex flex-col justify-center ml-12 w-4/5 '>
                        {postData.map((item, key) => <LikedPosts item={item} key={key} />)}
                    </div>
                </div>
            </div>
        </div>
    );
};

export default ProfilePage;
