import React, { useState, useEffect } from 'react';
import Navbarx from '../../components/navbar/Navbar';
import { getAllGames } from '../../services/gameService';
import CreateGame from './CreateGame';
import ImageList from '@mui/material/ImageList';
import ImageListItem from '@mui/material/ImageListItem';
import ImageListItemBar from '@mui/material/ImageListItemBar';
import IconButton from '@mui/material/IconButton';
import ArrowForwardIosIcon from '@mui/icons-material/ArrowForwardIos';
import gamePlaceHolder from '../../assets/img/game_place_holder.jpg';

const GameForum = () => {
    const [games, setGames] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const [searchQuery, setSearchQuery] = useState('');
    const [selectedGenre, setSelectedGenre] = useState('');
    const [selectedPlatform, setSelectedPlatform] = useState('');
    const [selectedPlayerNumber, setSelectedPlayerNumber] = useState('');
    const [selectedUniverseInfo, setSelectedUniverseInfo] = useState('');
    const [selectedGameMechanics, setSelectedGameMechanics] = useState('');

    const predefinedGenres = ['RGP', 'Strategy', 'Shooter', 'Sports', 'Fighting', 'MOBA', 'Action', 'Adventure', 'Simulation', 'Horror', 'Empty'];
    const predefinedPlatforms = ['XBOX', 'Computer', 'PS', 'Onboard', 'Mobile', 'Empty'];
    const predefinedPlayerNumber = ['Single', 'Teams', 'Multiplayer', 'MMO', 'Empty'];
    const predefinedUniverseInfo = ['Medieval', 'Fantasy', 'SciFi', 'Cyberpunk', 'Historical', 'Contemporary', 'PostApocalyptic', 'AlternateReality', 'Empty'];
    const predefinedGameMechanics = ['TurnBased', 'ChangeBased', 'RealTime', 'Empty'];

    useEffect(() => {
        const fetchGames = async () => {
            setIsLoading(true);
            try {
                const response = await getAllGames();
                setGames(response.data);
            } catch (error) {
                console.error(error);
            } finally {
                setIsLoading(false);
            }
        };
        fetchGames();
    }, []);

    const handleGenreChange = (event) => {
        setSelectedGenre(event.target.value);
    };

    const handlePlatformChange = (event) => {
        setSelectedPlatform(event.target.value);
    };

    const handlePlayerNumberChange = (event) => {
        setSelectedPlayerNumber(event.target.value);
    };

    const handleUniverseInfoChange = (event) => {
        setSelectedUniverseInfo(event.target.value);
    };

    const handleGameMechanicsChange = (event) => {
        setSelectedGameMechanics(event.target.value);
    };

    const handleImageError = (event) => {
        event.target.src = gamePlaceHolder;
    };

    const handleSearchInputChange = (event) => {
        setSearchQuery(event.target.value.toLowerCase());
    };

    if (isLoading) {
        return <div className='items-center justify-center flex'>Loading...</div>;
    }

    return (
        <>
            <Navbarx></Navbarx>
            <div className='w-full flex flex-col'>
                <div className='w-full flex justify-center p-4 bg-neutral-50 pb-20'>
                    <div className='w-3/4 flex flex-col'>
                        <h1 className='text-4xl font-bold text-neutral-700 text-center'>Games</h1>
                        <div className='w-full flex flex-row justify-between'>
                        <CreateGame />
                        <input
                            type="text"
                            placeholder="Search games..."
                            value={searchQuery}
                            onChange={handleSearchInputChange}
                            className="p-2 border border-neutral-300 text-neutral-600 rounded-md hover:bg-neutral-200 shadow-2xl"
                        />
                        </div>
                        <div className='flex w-full justify-between items-center mb-4 mt-4'>
                            <select value={selectedPlatform} onChange={handlePlatformChange} className="p-2 text-neutral-100 border bg-cyan-600 hover:bg-cyan-800 rounded-md">
                                <option value="">All Platforms</option>
                                {predefinedPlatforms.map((platform) => (
                                    <option key={platform} value={platform}>{platform}</option>
                                ))}
                            </select>
                            <select value={selectedPlayerNumber} onChange={handlePlayerNumberChange} className="p-2 text-neutral-100 border bg-cyan-600 hover:bg-cyan-800 rounded-md">
                                <option value="">All Player Numbers</option>
                                {predefinedPlayerNumber.map((playerNumber) => (
                                    <option key={playerNumber} value={playerNumber}>{playerNumber}</option>
                                ))}
                            </select>
                            <select value={selectedUniverseInfo} onChange={handleUniverseInfoChange} className="p-2 text-neutral-100 border bg-cyan-600 hover:bg-cyan-800 rounded-md">
                                <option value="">All Universe Info</option>
                                {predefinedUniverseInfo.map((universeInfo) => (
                                    <option key={universeInfo} value={universeInfo}>{universeInfo}</option>
                                ))}
                            </select>
                            <select value={selectedGameMechanics} onChange={handleGameMechanicsChange} className="p-2 text-neutral-100 border bg-cyan-600 hover:bg-cyan-800 rounded-md">
                                <option value="">All Game Mechanics</option>
                                {predefinedGameMechanics.map((gameMechanics) => (
                                    <option key={gameMechanics} value={gameMechanics}>{gameMechanics}</option>
                                ))}
                            </select>
                            <select value={selectedGenre} onChange={handleGenreChange} className="p-2 text-neutral-100 border bg-cyan-600 hover:bg-cyan-800 rounded-md">
                                <option value="">All</option>
                                {predefinedGenres.map((genre) => (
                                    <option key={genre} value={genre}>{genre}</option>
                                ))}
                            </select>
                        </div>
                        <ImageList className='w-full' cols={4} gap={8}>
                            {console.log(games)}
                            {games
                                .filter((game) => selectedGenre === '' || game.genres.includes(selectedGenre))
                                .filter((game) => selectedPlatform === '' || game.platforms.includes(selectedPlatform))
                                .filter((game) => selectedPlayerNumber === '' || game.playerNumber.includes(selectedPlayerNumber))
                                .filter((game) => selectedUniverseInfo === '' || game.universe.includes(selectedUniverseInfo))
                                .filter((game) => selectedGameMechanics === '' || game.mechanics.includes(selectedGameMechanics))
                                .filter((game) => searchQuery === '' || game.title.toLowerCase().includes(searchQuery))
                                .map((game) => (
                                    <ImageListItem key={game.gameId}>
                                        <img
                                            src={game.gamePicture || gamePlaceHolder}
                                            alt={game.title}
                                            loading="lazy"
                                            onError={handleImageError}
                                        />
                                        <ImageListItemBar
                                            title={<a href={`/game/${game.gameId}`} className='no-underline link text-white'>{game.title}</a>}
                                            actionIcon={
                                                <a href={`/game/${game.gameId}`} className='no-underline link'>
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
        </>
    );
};

export default GameForum;