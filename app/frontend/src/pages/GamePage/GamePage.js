import React from 'react';
import 'tailwindcss/tailwind.css';
import logo from '../../logo512.jpg';
import { Link } from 'react-router-dom';
import Navbarx from '../../components/navbar/Navbar';

const GamePage = () => {
	return (
		<>
			<Navbarx></Navbarx>
			<div className='w-full flex flex-col'>
				<div className='flex flex-row grow bg-gray-100'>
					<div className='w-full flex justify-center p-8 bg-gray-50 pb-20'>
						<div className='w-9/10 flex flex-col'>
							<div className="flex m-4">
								<p className='text-gray-600 mt-4'>Page created on: October 15, 2023 by @fifaloverr</p>
							</div>
							<div className='w-full flex flex-row'>
								<div className='w-3/5 flex flex-col'>
									<div className='card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<div className="flex">
											<div className="w-2/5 pr-4">
												<img src={logo} alt='Game Cover' className='w-full' />
											</div>
											<div className="w-3/5">
												<h2 className='text-3xl text-[#b46161] font-bold'>FIFA 23</h2>
												<br />
												<h2 className='text-xl font-bold'>Description</h2>
												<p className='text-gray-700 text-justify'>
													FIFA 23 is one of the most popular football simulation games developed by EA Sports.
													It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums.
													The game features various modes including career mode, ultimate team, and volta football,
													providing a diverse range of experiences for all football enthusiasts.
												</p>
												<br />
												<p className='text-gray-700 font-bold'>Release Date: 2023</p>
											</div>
										</div>
									</div>
									<div className='w-full flex flex-row'>
										<div className='w-1/2 card compact bg-gray-200 text-cyan-700 shadow-xl m-1 p-4'>
											<div className='w-full flex flex-row'>
												<h2 className='text-xl font-bold'>Rating:</h2>
												<p className='text-gray-700 p-1'>4.5/5</p>
												<br />
											</div>
											<div className="rating">
												<input type="radio" name="rating-1" className="mask mask-star" />
												<input type="radio" name="rating-1" className="mask mask-star" />
												<input type="radio" name="rating-1" className="mask mask-star" checked />
												<input type="radio" name="rating-1" className="mask mask-star" />
												<input type="radio" name="rating-1" className="mask mask-star" />
											</div>
										</div>
										<div className='w-1/2 card compact bg-gray-200 text-cyan-700 shadow-xl m-1 p-4'>
											<h2 className='text-xl font-bold'>Genre:</h2>
											<div className='flex flex-wrap'>
												<Link to="/genre/football" className='text-gray-700 mr-4'>Football</Link>
											</div>
										</div>
									</div>
								</div>
								<div className='w-2/5 flex flex-col'>
									<div className='h-full card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-2'>Features:</h2>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>Peer-to-Peer, Multiplayer</p>
										<h2 className='text-xl font-bold p-2'>Platform:</h2>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>PC, PS4, PS5, Xbox One, Xbox Series X/S</p>
										<h2 className='text-xl font-bold p-2'>Avatars:</h2>
										<p className='text-gray-700 p-2'>Football, EA Sports, Career Mode, Ultimate Team, Volta Football</p>
									</div>
								</div>
								<div className='w-1/5 flex flex-col'>
									<div className='h-full card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-1'>Games You May Like:</h2>
										<li className='mb-2'>
											<Link to="/content/fifa-22" className='text-gray-700 mr-4'>FIFA 22</Link>
										</li>
										<li className='mb-2'>
											<Link to="/content/uefa-euro-2020" className='text-gray-700 mr-4'>UEFA Euro 2020</Link>
										</li>

									</div>
								</div>

							</div>

						</div>

					</div>

				</div>

				<div className="bg-gray-400 text-white text-center p-8">
					<p className="text-m">@2023 Game Lounge, All rights reserved.</p>
				</div>
			</div>
		</>
	);
};

export default GamePage
