import React from 'react'
import 'tailwindcss/tailwind.css'
import Navbarx from '../../components/navbar/Navbar'
import { useState, useEffect } from 'react'
import { getAllGames } from '../../services/gameService'
import CreateGame from './CreateGame'
import GameCard from '../../components/navbar/GameCard'

const GameForum = () => {
  const [games, setGames] = useState([])
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    const fetchGames = async () => {
      setIsLoading(true)
      try {
        const response = await getAllGames()
        setGames(response.data)
      } catch (error) {
        console.error(error)
      } finally {
        setIsLoading(false)
      }
    }

    fetchGames()
  }, [])

  if (isLoading) {
    return <div className='items-center justify-center flex'>Loading...</div>
  }

  return (
    <>
      <Navbarx></Navbarx>
      <div className='w-full flex flex-col'>
        <div className='w-full flex justify-center p-4 bg-neutral-50 pb-20'>
          <div className='w-3/6 flex flex-col'>
            <h1 className='text-4xl font-bold text-neutral-700 text-center'>Games</h1>
            <CreateGame />
            <div className='w-full flex flex-row'>
              <div className='w-full flex flex-col'>
                {games.filter(game => game.status === 'APPROVED').map((game) => (
                  <GameCard key={game.gameID} game={game} />
                ))}
              </div>
            </div>
          </div>
        </div>
        <div className='bg-black text-white text-center p-8'>
          <p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
        </div>
      </div>
    </>
  )
}

export default GameForum
