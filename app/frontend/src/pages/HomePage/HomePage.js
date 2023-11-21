import React from 'react';
import Suggestion from './Suggestion';
import Post from './Post';
import Group from './Group';
import Sidebar from '../../components/Sidebar';
import * as images from '../../pages/Auth/images';

export default function HomePage() {
  const groupData = [
    {
      image: images.pubg,
      header: '"Looking for a co-op adventure in Hyrule!"',
      text:
        "Need a skilled squad for high-intensity chicken dinners! Who's in for some PUBG action? Let's conquer the battleground together! 🍗🔫",
      players: '4/5',
    },
    {
      image: images.fortnite,
      header: '"Searching for squadmates for some intense battle royale action!"',
      text:
        "Building forts and taking names! Searching for fellow Fortnite warriors to join my squad. Let's get those Victory Royales! 🏰👑",
      players: '4/5',
    },
    {
      image: images.rocketleague,
      header: 'Anyone for Rocket league',
      text:
        "Ready to score some goals and pull off epic aerials? Looking for Rocket League teammates who can bring the heat on the field. Let's drive to victory! 🚗⚽",
      players: '4/5',
    },
  ];

  const suggestionData = [
    {
      image: images.kerimbahadir,
      username: 'Kerim Bahadır',
      tag: '#counterstrike #developer',
    },
    {
      image: images.alikasap,
      username: 'Ali Kasap',
      tag: '#counterstrike #gamer #rpg',
    },
    {
      image: images.zehrayildirim,
      username: 'Zehra Yıldırım',
      tag: '#counterstrike #dota2',
    },
    {
      image: images.mahmutdemir,
      username: 'Mahmut Demir',
      tag: '#counterstrike #fighter',
    },
  ];

  const postData = [
    {
      image: images.residentevil,
      header: 'Resident Evil 4 Remake',
      content:
        "Looking for someone to join me in my Resident Evil 4 adventure! Let's team up and face the horrors together.️ #ResidentEvil4 #GamingBuddyWanted",
      date: '29.10.2023  00.00',
    },
    {
      image: images.fifa,
      header: 'Fifa',
      content:
        "FIFA is one of the most popular football simulation games developed by EA Sports. It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums.",
      date: '29.10.2023  00.00',
    },
    {
      image: images.witcher,
      header: 'The Witcher 3: Wild Hunt',
      content:
        "The Witcher 3 is an unforgettable gaming experience. Its open world, rich storytelling, and captivating characters make it a must-play RPG. If you love epic adventures, this one's a masterpiece.",
      date: '29.10.2023  00.00',
    },
  ];

  return (
    <div className='flex flex-row grow bg-gray-50'>
      {/* Make elements flex, these will be in a row */}
      <div className='w-1/5 flex flex-col gap-4'>
        {/* Take 1/5 width of the screen, flex elements in a column, add gap between elements */}
        <Sidebar />
      </div>
      <div className='w-4/5 flex flex-col gap-4'>
        {/* Take 4/5 width of the screen, flex elements in a column, add gap between elements */}
        <div className='flex w-full justify-center'>
          {/* In the full width you can take (i.e. 4/5), flex elements in a row, center them */}
          {suggestionData.map((item, key) => (
            <Suggestion item={item} key={key} />
          ))}
        </div>
        <div className='flex flex-row mx-4'>
          {/* Flex elements in a row, add margin on the left and right */}
          <div className='flex flex-col w-1/2 ml-4 mr-2'>
            {/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
            {postData.map((item, key) => (
              <Post item={item} key={key} />
            ))}
          </div>
          <div className='flex flex-col w-1/2 mr-4 ml-2'>
            {/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
            {groupData.map((item, key) => (
              <Group item={item} key={key} />
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
