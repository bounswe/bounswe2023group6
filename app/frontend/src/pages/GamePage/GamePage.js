import React from 'react';
import 'tailwindcss/tailwind.css';
import logo from '../../logo512.jpg';
import gamelounge from '../../gamelounge.png'
import Sidebar from '../../components/Sidebar';
import { Link } from 'react-router-dom';

const GamePage = () => {
  return (
    <>
      <div className='w-full flex flex-col'>
        <div className='flex justify-center items-center p-1'>
          <img src={gamelounge} alt='Site Logo' className='h-24' />
        </div>
        <div className='flex flex-row grow bg-gray-100'>
          <div className='w-1/5 flex flex-col gap-4'>
            <Sidebar />
          </div>
          <div className='w-full flex justify-center p-8 bg-gray-200 pb-20'>
            <div className='w-9/10 flex flex-col'>
              <div className="flex m-4">
                <p className='text-gray-700'>Page created on: October 15, 2023</p>
              </div>
              <div className='w-full flex flex-row'>
                <div className='w-3/5 flex flex-col'>
                  <div className='card compact bg-gray-50 text-sky-800 shadow-xl m-2 p-4'>
                    <div className="flex">
                      <div className="w-2/5 pr-4">
                        <img src={logo} alt='Game Cover' className='w-full' />
                      </div>
                      <div className="w-3/5">
                        <h2 className='text-3xl font-bold'>FIFA 23</h2>
                        <br />
                        <p className='text-gray-700 text-justify'>
                          FIFA 23 is one of the most popular football simulation games developed by EA Sports.
                          It offers an immersive gaming experience with realistic graphics, player mechanics, and stadiums.
                          The game features various modes including career mode, ultimate team, and volta football,
                          providing a diverse range of experiences for all football enthusiasts.
                        </p>
                        <br />
                        <p className='text-gray-700 font-bold'>Release Year: 2023</p>
                      </div>
                    </div>
                  </div>
                  <div className='w-full flex flex-row'>
                    <div className='w-1/2 card compact bg-gray-50 text-sky-800 shadow-xl m-1 p-4'>
                    <div className='w-full flex flex-row'>
                      <h2 className='text-xl font-bold'>Rating:</h2>
                      <p className='text-gray-700 p-1'>4.5/5</p>
                      <br/>
                      </div>
                      <div className="rating">
                        <input type="radio" name="rating-1" className="mask mask-star" />
                        <input type="radio" name="rating-1" className="mask mask-star" />
                        <input type="radio" name="rating-1" className="mask mask-star" checked/>
                        <input type="radio" name="rating-1" className="mask mask-star" />
                        <input type="radio" name="rating-1" className="mask mask-star" />
                      </div>
                    </div>
                    <div className='w-1/2 card compact bg-gray-50 text-sky-800 shadow-xl m-1 p-4'>
                      <h2 className='text-xl font-bold'>Genre:</h2>
                      <div className='flex flex-wrap'>
                        <Link to="/genre/football" className='text-blue-500 hover:underline mr-4'>Football</Link>
                        <Link to="/genre/sports" className='text-blue-500 hover:underline mr-4'>Sports</Link>
                      </div>
                    </div>
                  </div>
                </div>
                <div className='w-2/5 flex flex-col'>
                  <div className='h-full card compact bg-gray-50 text-sky-800 shadow-xl m-2 p-4'>
                    <h2 className='text-2xl font-bold p-1'>Features:</h2>
                    <p className='text-gray-700 border-b-2 border-gray-400 p-1'>Peer-to-Peer, Multiplayer</p>
                    <h2 className='text-2xl font-bold p-1'>Platform:</h2>
                    <p className='text-gray-700 border-b-2 border-gray-400 p-1'>PC, PS4, PS5, Xbox One, Xbox Series X/S</p>
                    <h2 className='text-2xl font-bold p-1'>Games You May Like:</h2>
                    <ul className='border-b-2 border-gray-400 p-1'>
                      <li className='mb-2'>
                        <Link to="/content/fifa-22" className='text-blue-500 hover:underline'>FIFA 22</Link>
                      </li>
                      <li className='mb-2'>
                        <Link to="/content/uefa-euro-2020" className='text-blue-500 hover:underline'>UEFA Euro 2020</Link>
                      </li>
                      <li className='mb-2'>
                        <Link to="/content/football-manager-2022" className='text-blue-500 hover:underline'>Football Manager 2022</Link>
                      </li>
                    </ul>
                    <h2 className='text-2xl font-bold p-1'>Knowledge Base:</h2>
                    <p className='text-gray-700 p-1'>Football, EA Sports, Career Mode, Ultimate Team, Volta Football</p>
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

export default GamePage;