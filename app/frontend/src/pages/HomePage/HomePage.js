import React from 'react'
import Suggestion from './Suggestion'
import Post from './Post'
import Group from './Group'
import Navbarx from '../../components/navbar/Navbar'

export default function HomePage() {
	const groupData = [
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			header: '"Looking for a co-op adventure in Hyrule!"',
			text: "Need a skilled squad for high-intensity chicken dinners! Who's in for some PUBG action? Let's conquer the battleground together! 🍗🔫",
			players: '4/5'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			header: '"Searching for squadmates for some intense battle royale action!"',
			text: "Building forts and taking names! Searching for fellow Fortnite warriors to join my squad. Let's get those Victory Royales! 🏰👑",
			players: '4/5'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			header: 'Anyone for Rocket league',
			text: "Ready to score some goals and pull off epic aerials? Looking for Rocket League teammates who can bring the heat on the field. Let's drive to victory! 🚗⚽",
			players: '4/5'
		}
	]

	const suggestionData = [
		{
			image: `https://primefaces.org/cdn/primereact/images/product/bamboo-watch.jpg}`,
			username: 'Kerim Bahadır',
			tag: '#counterstrike #developer'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/brown-purse.jpg}`,
			username: 'Ali Kasap',
			tag: '#counterstrike #gamer #rpg'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/galaxy-earrings.jpg}`,
			username: 'Zehra Yıldırım',
			tag: '#counterstrike .#dota2'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			username: 'Mahmut Demir',
			tag: '#counterstrike #fighter'
		}
	]

	const postData = [
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			header: 'Resident Evil 4 Remake',
			content:
				"Looking for someone to join me in my Resident Evil 4 adventure! Let's team up and face the horrors together.️ #ResidentEvil4 #GamingBuddyWanted",
			date: '29.10.2023  00.00'
		},
		{
			image: 'https://primefaces.org/cdn/primereact/images/product/game-controller.jpg',
			header: 'Fifa',
			content:
				'FIFA is one of the most popular football simulation games developed by EA Sports. It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums.',
			date: '29.10.2023  00.00'
		},
		{
			image: `https://primefaces.org/cdn/primereact/images/product/game-controller.jpg}`,
			header: 'The Witcher 3: Wild Hunt',
			content:
				"The Witcher 3 is an unforgettable gaming experience. Its open world, rich storytelling, and captivating characters make it a must-play RPG. If you love epic adventures, this one's a masterpiece.",
			date: '29.10.2023  00.00'
		}
	]

  return (
    <>
    <Navbarx></Navbarx>
    <div className='flex flex-row grow bg-gray-50'>
      {/* Make elements flex, these will be in a row */}
      {/* <div className='w-1/5 flex flex-col gap-4'> */}
        {/* Take 1/5 width of the screen, flex elements in a column, add gap between elements */}
      {/* </div> */}
      <div className='flex flex-col gap-4 ml-12 mr-12'>
        {/* Take 4/5 width of the screen, flex elements in a column, add gap between elements */}
        <div className='flex w-full justify-center'>
          {/* In the full width you can take (i.e. 4/5), flex elements in a row, center them */}
          {suggestionData.map((item, key) => (
            <Suggestion item={item} key={key} />
          ))}
        </div>
        <div className='flex flex-row mx-4'>
          {/* Flex elements in a row, add margin on the left and right */}
          <div className='flex flex-col w-1/2 ml-12 mr-12'>
            {/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
            {postData.map((item, key) => (
              <Post item={item} key={key} />
            ))}
          </div>
          <div className='flex flex-col w-1/2 ml-12 mr-12'>
            {/* Take 1/2 width of the screen, flex elements in a column, add margin on the left and right */}
            {groupData.map((item, key) => (
              <Group item={item} key={key} />
            ))}
          </div>
        </div>
      </div>
    </div>
    </>
  )
};