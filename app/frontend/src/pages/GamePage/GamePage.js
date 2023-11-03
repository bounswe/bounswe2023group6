// src/pages/GamePage/GamePage.js
import React from 'react';
import 'tailwindcss/tailwind.css';
import logo from '../../logo512.jpg';
import { Link } from 'react-router-dom';

const GamePage = () => {
  return (
		<div className='bg-gray-200 py-20 flex justify-center items-center'>
			<div className='max-w-md mx-auto bg-white rounded-lg overflow-hidden shadow-lg'>
				<img className='w-full h-full' src={logo} alt="Fifa 23" />
				<div className='p-8'>
				<h1 className='text-2xl font-bold mb-3 text-gray-700'>Fifa 23</h1>
				<p className='text-gray-600 mb-3'>
					FIFA 23 is one of the most popular football simulation games developed by EA Sports. 
					It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums. 
					The game features various modes including career mode, ultimate team, and volta football, 
					providing a diverse range of experiences for all football enthusiasts.
				</p>
				<p className='text-gray-600 mb-3'>
					<strong>Rating:</strong> 4.5/5
				</p>
				<p className='text-gray-600 mb-3'>
					<strong>Genre:</strong> Football, Sports<br/>
					<strong>Features:</strong> Peer-to-Peer, Multiplayer<br/>
					<strong>Platform:</strong> PC, PS4, PS5, Xbox One, Xbox Series X/S
				</p>
			
				<div className='p-8'>
					<h2 className='text-xl font-bold mb-3 text-gray-700'>Knowledge Base</h2>
					<div className='flex flex-wrap'>
						<Link to="/knowledge/football" className='text-blue-500 hover:underline mr-4'>Football</Link>
						<Link to="/knowledge/ea-sports" className='text-blue-500 hover:underline mr-4'>EA Sports</Link>
						<Link to="/knowledge/career-mode" className='text-blue-500 hover:underline mr-4'>Career Mode</Link>
						<Link to="/knowledge/ultimate-team" className='text-blue-500 hover:underline mr-4'>Ultimate Team</Link>
						<Link to="/knowledge/volta-football" className='text-blue-500 hover:underline mr-4'>Volta Football</Link>
					</div>
				</div>
				<div className='p-8'>
					<h2 className='text-xl font-bold mb-3 text-gray-700'>Games You May Like</h2>
					<div className='flex flex-wrap'>
						<Link to="/content/fifa-22" className='text-blue-500 hover:underline mr-4'>FIFA 22</Link>
						<Link to="/content/uefa-euro-2020" className='text-blue-500 hover:underline mr-4'>UEFA Euro 2020</Link>
						<Link to="/content/football-manager-2022" className='text-blue-500 hover:underline mr-4'>Football Manager 2022</Link>
					</div>
				</div>
			</div>
		</div>
    </div>
	);
};

export default GamePage;