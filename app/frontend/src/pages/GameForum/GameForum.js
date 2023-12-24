import React from 'react'
import 'tailwindcss/tailwind.css'
import Navbarx from '../../components/navbar/Navbar'
import { useState, useEffect } from 'react'
import { getAllGames } from '../../services/gameService'
import CreateGame from './CreateGame'
import ImageList from '@mui/material/ImageList'
import ImageListItem from '@mui/material/ImageListItem'
import ImageListItemBar from '@mui/material/ImageListItemBar'
import IconButton from '@mui/material/IconButton';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import gamePlaceHolder from '../../assets/img/game_place_holder.jpg'

const GameForum = () => {
  const [games, setGames] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [searchQuery, setSearchQuery] = useState('');
  const [filteredGames, setFilteredGames] = useState([]);

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

  const handleImageError = (event) => {
      event.target.src = gamePlaceHolder;
    };

  const handleSearchInputChange = (event) => {
    const query = event.target.value.toLowerCase();
    setSearchQuery(query);

    if (query === '') {
      setFilteredGames([]);
    } else {
      const filtered = games.filter((game) => game.title.toLowerCase().includes(query));
      setFilteredGames(filtered);
    }
  };

  if (isLoading) {
    return <div className='items-center justify-center flex'>Loading...</div>
  }

  return (
    <>
      <Navbarx></Navbarx>
      <div className='w-full flex flex-col'>
        <div className='w-full flex justify-center p-4 bg-neutral-50 pb-20'>
          <div className='w-3/4 flex flex-col'>
            <h1 className='text-4xl font-bold text-neutral-700 text-center'>Games</h1>
            <div className='w-full flex flex-row justify-between items-center'>
            <CreateGame />
            <input
              type="text"
              placeholder="Search games..."
              value={searchQuery}
              onChange={handleSearchInputChange}
              className="p-2 border border-gray-300 rounded-md"
            />
            </div>
            <div className='w-full flex flex-row pt-4'>
              <ImageList className='w-full h-full' style={{ gridTemplateColumns: 'repeat(4, 1fr)' }}>
                                          {searchQuery
                                            ? filteredGames
                                                .filter((game) => game.status === 'APPROVED')
                                                .map((game) => (
                                                  <ImageListItem key={game.gameID} className='m-1'>
                                                    <img
                                                    src={game.gamePicture}
                                                    alt={game.title}
                                                    loading="lazy"
                                                    onError={handleImageError}
                                                    />
                                                    <ImageListItemBar
                                                      title={<a href={`/games/${game.gameID}`} className='no-underline link'>{game.title}</a>}
                                                      actionIcon={
                                                        <IconButton sx={{ color: 'rgba(255, 255, 255, 0.9)' }}>
                                                          <ArrowForwardIosIcon />
                                                        </IconButton>
                                                      }
                                                    />
                                                  </ImageListItem>
                                                ))
                                            : games
                                                .filter((game) => game.status === 'APPROVED')
                                                .map((game) => (
                                                  <ImageListItem key={game.gameID} className='m-1'>
                                                    <img src={game.gamePicture} alt={game.title} loading="lazy" onError={handleImageError}/>
                                                    <ImageListItemBar
                                                      title={<a href={`/game/${game.gameID}`} className='no-underline link text-white'>{game.title}</a>}
                                                      actionIcon={
                                                        <a href={`/game/${game.gameID}`} className='no-underline link'>
                                                                                <IconButton sx={{ color: 'rgba(255, 255, 255, 0.9)' }}>
                                                                                  <ArrowForwardIosIcon />
                                                                                </IconButton>
                                                                              </a>
                                                      }
                                                    />
                                                  </ImageListItem>
                                                ))}
                                        </ImageList>
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

