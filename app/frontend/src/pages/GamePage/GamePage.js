import React from 'react'
import 'tailwindcss/tailwind.css'
import { Link } from 'react-router-dom'
import Navbarx from '../../components/navbar/Navbar'
import { useState, useEffect } from 'react'
import { getGame, rateGame } from '../../services/gameServise'
import { useParams } from 'react-router-dom'
import { getAllGames } from '../../services/gameService'
import { useNavigate } from 'react-router-dom'
const GamePage = () => {
	const navigate = useNavigate() // Use useNavigate instead of useHistory

	const { gameId } = useParams()
	console.log(gameId)

	const [game, setGames] = useState({
		gameId: 0,
		title: 'string',
		description: 'string',
		genre: 'string',
		platform: 'string',
		characters: [
			{
				characterId: 0,
				name: 'string',
				description: 'string',
				gameID: 0
			}
		],
		playerNumber: 'string',
		releaseYear: 0,
		universe: 'string',
		mechanics: 'string',
		playtime: 'string',
		totalRating: 0,
		countRating: 0,
		averageRating: 0,
		creationDate: '2023-11-27T15:17:41.937Z',
		tags: [
			{
				tagId: 0,
				name: 'string'
			}
		],
		gamePicture: 'string'
	})
	useEffect(() => {
		const game = async () => {
			try {
				const response = await getGame(gameId)
				console.log(response.data)
				setGames(response.data)
			} catch (error) {
				console.error(error)
			} finally {
				console.log(game)
			}
		}
		game()
	}, [gameId])

	const [rating, setRating] = useState(null)
	const [hasRated, setHasRated] = useState(false)

	const handleRatingChange = (selectedRating) => {
		setRating(selectedRating)
	}

	const handleRateGame = async () => {
		if (!hasRated && rating !== null) {
			try {
				await rateGame(gameId, rating) // Assuming gameId is 1, replace with actual gameId if necessary
				setHasRated(true)
			} catch (error) {
				if (error.response && error.response.status === 403) {
					alert('You cannot vote more than once.')
				} else {
					console.error('Error rating game:', error)
				}
			}
		}
	}
	const [gamesmyliked, setGamesMyLiked] = useState([])
	useEffect(() => {
		const fetchGames = async () => {
			try {
				const response = await getAllGames()
				setGamesMyLiked(response.data.slice(0, 4))
			} catch (error) {
				console.error(error)
			} finally {
				console.log('all games')
			}
		}

		fetchGames()
	}, [])

	return (
		<>
			<Navbarx></Navbarx>
			<div className='w-full flex flex-col'>
				<div className='flex flex-row grow bg-gray-100'>
					<div className='w-full flex justify-center p-8 bg-gray-50 pb-20'>
						<div className='w-9/10 flex flex-col'>
							<div className='flex m-4'>
								<p className='text-gray-600 mt-4'>Page created on: October 15, 2023 by @fifaloverr</p>
							</div>
							<div className='w-full flex flex-row'>
								<div className='w-3/5 flex flex-col'>
									<div className='card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<div className='flex'>
											<div className='w-2/5 pr-4'>
												<img src={game.gamePicture} alt='Game Cover' className='w-full' />
											</div>
											<div className='w-3/5'>
												<h2 className='text-3xl text-[#b46161] font-bold'>{game.title}</h2>
												<br />
												<h2 className='text-xl font-bold'>Description</h2>
												<p className='text-gray-700 text-justify'>{game.description}</p>
												<br />
												<p className='text-gray-700 font-bold'>{game.releaseYear}</p>
											</div>
										</div>
									</div>
									<div className='w-full flex flex-row'>
										<div className='w-1/2 card compact bg-gray-200 text-cyan-700 shadow-xl m-1 p-4'>
											<div className='w-full flex flex-row'>
												<h2 className='text-xl font-bold'>Rating:</h2>
												<p className='text-gray-700 p-1'>{game.averageRating}</p>
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
											<button className='btn btn-primary w-1/2 mt-2 ' onClick={() => handleRateGame()}>
												Rate Game
											</button>
										</div>
										<div className='w-1/2 card compact bg-gray-200 text-cyan-700 shadow-xl m-1 p-4'>
											<h2 className='text-xl font-bold'>Genre:</h2>
											<div className='flex flex-wrap'>
												<Link to='/genre/football' className='text-gray-700 mr-4'>
													{game.genre}
												</Link>
											</div>
										</div>
									</div>
								</div>
								<div className='w-2/5 flex flex-col'>
									<div className='h-full card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-2'>Features:</h2>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>Mechanics: {game.mechanics}</p>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>Universe : {game.universe}</p>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>Playtime: {game.playtime}</p>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>Player number : {game.playerNumber}</p>
										<h2 className='text-xl font-bold p-2'>Platform:</h2>
										<p className='text-gray-700 border-b-2 border-gray-400 p-2'>{game.platform}</p>
										<h2 className='text-xl font-bold p-2'>Game Details:</h2>

										{game.characters.map((character) => (
											<div key={character.characterId}>
												<p className='text-gray-700 border-b-2 border-gray-400 p-2'> {character.name}</p>
												<p className='text-gray-700 border-b-2 border-gray-400 p-2'>{character.description}</p>
											</div>
										))}
									</div>
								</div>
								<div className='w-1/5 flex flex-col'>
									<div className='h-full card compact bg-gray-200 text-cyan-700 shadow-xl m-2 p-4'>
										<h2 className='text-xl font-bold p-1'>Games You May Like:</h2>
										{gamesmyliked.map((game) => (
											<li key={game.id} className='mb-2'>
												<button
													onClick={() => {
														navigate(`/game/${game.gameId}`) // Use navigate for programmatic navigation
													}}
													className='text-gray-700 mr-4'
												>
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

				<div className='bg-gray-400 text-white text-center p-8'>
					<p className='text-m'>@2023 Game Lounge, All rights reserved.</p>
				</div>
			</div>
		</>
	)
}

export default GamePage
