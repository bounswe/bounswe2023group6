import React, { useState, useEffect } from 'react'
import 'tailwindcss/tailwind.css'
import { useParams, useNavigate } from 'react-router-dom'
import Navbarx from '../../components/navbar/Navbar'
import { getGame, rateGame } from '../../services/gameService'
// import { getAllGames } from '../../services/gameService';
import EditGame from '../GameForum/EditGame'
const GamePage = () => {
	const navigate = useNavigate()
	const { gameId } = useParams()

	const [game, setGame] = useState(null)
	const [rating, setRating] = useState(null)
	const [hasRated, setHasRated] = useState(false)
	const [similarGames, setSimilarGames] = useState([])

	useEffect(() => {
		const fetchGame = async () => {
			try {
				const response = await getGame(gameId)
				setGame(response.data)
				setSimilarGames(response.data.similarGames)
			} catch (error) {
				console.error(error)
			}
		}
		fetchGame()
	}, [gameId])

	const handleRatingChange = (selectedRating) => {
		setRating(selectedRating)
	}

	const handleRateGame = async () => {
		if (!hasRated && rating !== null) {
			try {
				await rateGame(gameId, rating)
				setHasRated(true)
			} catch (error) {
				console.error('Error rating game:', error)
			}
		}
	}

	return (
		<>
			<Navbarx />
			<div className='w-full flex flex-col'>
				<div className='flex flex-row grow bg-neutral-100'>
					<div className='w-full flex justify-center p-8 bg-neutral-50 pb-20'>
						<div className='w-9/10 flex flex-col'>
							<div className='flex m-4'>
								<p className='text-neutral-600 mt-4'>
									Page created on: {new Date(game?.creationDate).toLocaleDateString()}
								</p>
							</div>
							{game && <EditGame game={game} />}
							<div className='w-full flex flex-row'>
								<div className='w-3/5 flex flex-col'>
									<div className='card compact bg-neutral-200 text-cyan-700 shadow-xl m-2 p-4'>
										<div className='flex'>
											<div className='w-2/5 pr-4'>
												<img src={game?.gamePicture} alt='Game Cover' className='w-full' />
											</div>
											<div className='w-3/5'>
												<h2 className='text-3xl text-[#b46161] font-bold'>{game?.title}</h2>
												<br />
												<h2 className='text-xl font-bold'>Description</h2>
												<p className='text-neutral-700 text-justify'>{game?.description}</p>
												<br />
												<p className='text-neutral-700'>
													Release Year: <b>{game?.releaseYear}</b>
												</p>
											</div>
										</div>
									</div>
									<div className='w-full flex flex-row'>
										<div className='w-1/2 card compact bg-neutral-200 text-cyan-700 shadow-xl m-1 p-4'>
											<div className='w-full flex flex-row'>
												<h2 className='text-xl font-bold'>Rating:</h2>
												<p className='text-neutral-700 p-1'>{game?.averageRating}</p>
												<br />
											</div>
											<div className='rating w-full flex flex-row'>
												{[1, 2, 3, 4, 5].map((value) => (
													<input
														key={value}
														type='radio'
														name='rating-1'
														className='mask mask-star'
														onChange={() => handleRatingChange(value)}
														checked={value === rating}
													/>
												))}
											</div>
											<button className='btn btn-primary w-1/2 mt-2' onClick={handleRateGame}>
												Rate Game
											</button>
										</div>
										<div className='w-1/2 card compact bg-neutral-200 text-cyan-700 shadow-xl m-1 p-4'>
											<h2 className='text-xl font-bold'>Genre:</h2>
											<div className='flex flex-wrap'>
												{game?.genres.map((genre, index) => (
													<p key={index} className='text-neutral-700 mr-4'>
														{genre}
													</p>
												))}
											</div>
										</div>
									</div>
								</div>
								<div className='w-2/5 flex flex-col'>
									<div className='h-full card compact bg-neutral-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-2'>Features:</h2>
										<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'>Mechanics: {game?.mechanics}</p>
										<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'>Universe : {game?.universe}</p>
										<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'>Playtime: {game?.playtime}</p>
										<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'>
											Player number : {game?.playerNumber}
										</p>
										<h2 className='text-xl font-bold p-2'>Platform:</h2>
										<div className='flex flex-wrap'>
											{game?.platforms.map((platform, index) => (
												<p key={index} className='text-neutral-700 border-b-2 border-neutral-400 p-2'>
													{platform}
												</p>
											))}
										</div>
										{/* <h2 className='text-xl font-bold p-2'>Game Details:</h2> */}
										{/* {game?.characters.map((character, index) => (
											<div key={index}>
												<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'> {character.name}</p>
												<p className='text-neutral-700 border-b-2 border-neutral-400 p-2'>{character.description}</p>
											</div>
										))} */}
									</div>
								</div>
								<div className='w-1/5 flex flex-col'>
									<div className='h-full card compact bg-neutral-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-1'>Games You May Like:</h2>
										{similarGames.map((game) => (
											<li key={game.gameId} className='mb-2'>
												<button onClick={() => navigate(`/game/${game.gameId}`)} className='text-neutral-700 mr-4'>
													{game.title}
												</button>
											</li>
										))}
									</div>
								</div>
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

export default GamePage
