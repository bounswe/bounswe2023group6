import React, { useState } from 'react'
import {
	Dialog,
	DialogTitle,
	DialogContent,
	TextField,
	DialogActions,
	Button,
	IconButton,
	MenuItem,
	OutlinedInput,
	FormControl,
	Select,
	InputLabel,
	Checkbox,
	ListItemText
} from '@mui/material'
import CloseIcon from '@mui/icons-material/Close'
import { useForm } from 'react-hook-form'
import axios from 'axios'
import EditIcon from '@mui/icons-material/Edit'

export default function EditGame(props) {
	const api_url = process.env.REACT_APP_API_URL
	const { handleSubmit } = useForm()
	const [open, setOpen] = useState(false)
	const [gameData, setGameData] = useState({
		title: props.game.title,
		description: props.game.description,
		genre: props.game.genre,
		platform: props.game.platform,
		playerNumber: props.game.playerNumber,
		releaseYear: props.game.releaseYear,
		universe: props.game.universe,
		mechanics: props.game.mechanics,
		playtime: props.game.playtime,
		image: null
	})
	const [selectedImage, setSelectedImage] = useState(null)

	const handleImageChange = async (e) => {
		const file = e.target.files[0]
		const reader = new FileReader()
		reader.onloadend = () => {
			const arrayBuffer = reader.result
			const byteArray = new Uint8Array(arrayBuffer)
			setSelectedImage(byteArray)
			setSelectedImage(new Blob([byteArray]))
		}
		reader.readAsArrayBuffer(file)
	}

	const handleUniverseInfoChange = (event) => {
		setSelectedUniverseInfo(event.target.value)
	}
	const handleUploadButtonClick = () => {
		// Programmatically trigger the file input
		document.getElementById('imageInput').click()
	}

	const predefinedGenres = [
		'RGP',
		'Strategy',
		'Shooter',
		'Sports',
		'Fighting',
		'MOBA',
		'Action',
		'Adventure',
		'Simulation',
		'Horror',
		'Empty'
	]
	const predefinedPlatforms = ['XBOX', 'Computer', 'PS', 'Onboard', 'Mobile', 'Empty']
	const predefinedPlayerNumber = ['Single', 'Teams', 'Multiplayer', 'MMO', 'Empty']
	const predefinedUniverseInfo = [
		'Medieval',
		'Fantasy',
		'SciFi',
		'Cyberpunk',
		'Historical',
		'Contemporary',
		'PostApocalyptic',
		'AlternateReality',
		'Empty'
	]
	const predefinedGameMechanics = ['TurnBased', 'ChangeBased', 'RealTime', 'Empty']

	//turn string into array
	const [selectedGenres, setSelectedGenres] = useState(props.game.genres)
	const [selectedPlatforms, setSelectedPlatforms] = useState(props.game.platforms)
	const [selectedGameMechanics, setSelectedGameMechanics] = useState(props.game.mechanics)
	const [selectedPlayerNumber, setSelectedPlayerNumber] = useState(props.game.playerNumber)
	const [selectedUniverseInfo, setSelectedUniverseInfo] = useState(props.game.universe)
	const handleClickOpen = () => {
		setOpen(true)
	}

	const handleClose = () => {
		setOpen(false)
		clearData()
	}

	const onSubmit = async () => {
		const postData = {
			...gameData,

			genre: selectedGenres.toString(),
			platform: selectedPlatforms.toString(),
			playerNumber: selectedPlayerNumber.toString(),
			universe: selectedUniverseInfo.toString(),
			image: selectedImage
		}
		delete postData.characters
		const { title, description, genre, platform, playerNumber, releaseYear, universe, mechanics, playtime, image } = postData
		const request = { title, description, genre, platform, playerNumber, releaseYear, universe, mechanics, playtime, image }
		const formDataToSend = new FormData()

		formDataToSend.append('request', new Blob([JSON.stringify(request)], { type: 'application/json' }))
		if (selectedImage) {
			const file = new File([selectedImage], 'image.png', { type: 'image/png' })
			formDataToSend.append('image', file)
		}
		try {
			const response = await axios.post(`${api_url}/game/${props.game.gameId}`, formDataToSend, {
				headers: {
					'Content-Type': 'multipart/form-data'
				}
			})

			if (response.status === 201) {
				console.log('Game created successfully!')
			}
		} catch (error) {
			console.log(request)
			console.log(error)
		}
	}

	const clearData = () => {
		setGameData({
			title: '',
			description: '',
			genre: [],
			platform: [],
			playerNumber: '',
			releaseYear: 0,
			universe: '',
			mechanics: '',
			playtime: '',
			image: null,
			characters: []
		})
		setSelectedGenres([])
		setSelectedPlatforms([])
	}

	const handleChange = (property, value) => {
		setGameData((prevData) => ({ ...prevData, [property]: value }))
	}
	const handlePlayerNumberChange = (event) => {
		setSelectedPlayerNumber(event.target.value)
	}

	const handleGameMechanicsChange = (event) => {
		setSelectedGameMechanics(event.target.value)
	}
	const handleGenreChange = (event) => {
		setSelectedGenres(event.target.value)
	}

	const handlePlatformChange = (event) => {
		setSelectedPlatforms(event.target.value)
	}

	const handleAddCharacter = () => {
		setGameData((prevData) => ({
			...prevData,
			characters: [...prevData.characters, { name: ``, description: `` }]
		}))
	}

	return (
		<div>
			<Button variant='outlined' onClick={handleClickOpen}>
				<EditIcon sx={{ color: 'black' }} /> Edit Game
			</Button>

			<Dialog open={open} onClose={handleClose} fullWidth>
				<DialogTitle>
					Edit Game
					<IconButton edge='end' color='inherit' onClick={handleClose} sx={{ position: 'absolute', right: 8, top: 8 }}>
						<CloseIcon />
					</IconButton>
				</DialogTitle>
				<Button
					edge='end'
					variant='text'
					color='warning'
					onClick={handleAddCharacter}
					sx={{ position: 'absolute', right: 35, top: 12, width: 150 }}
				>
					Add Character
				</Button>
				<DialogContent>
					{Object.entries(gameData).map(([property, value]) => (
						<div key={property}>
							{property === 'description' ? (
								<TextField
									label={property.charAt(0).toUpperCase() + property.slice(1)}
									required
									fullWidth
									margin='normal'
									multiline
									rowsMax={10}
									value={value}
									onChange={(event) => handleChange(property, event.target.value)}
								/>
							) : property === 'genre' ? (
								<FormControl fullWidth margin='normal'>
									<InputLabel id='genre-label'>Genres</InputLabel>
									<Select
										label='Genres'
										multiple
										value={selectedGenres}
										onChange={handleGenreChange}
										input={<OutlinedInput label='Genres' />}
										renderValue={(selected) => selected.join(', ')}
									>
										{predefinedGenres.map((genre) => (
											<MenuItem key={genre} value={genre}>
												<Checkbox checked={selectedGenres.indexOf(genre) > -1} />
												<ListItemText primary={genre} />
											</MenuItem>
										))}
									</Select>
								</FormControl>
							) : property === 'platform' ? (
								<FormControl fullWidth margin='normal'>
									<InputLabel id='platform-label'>Platforms</InputLabel>
									<Select
										label='Platforms'
										multiple
										value={selectedPlatforms}
										onChange={handlePlatformChange}
										input={<OutlinedInput label='Platforms' />}
										renderValue={(selected) => selected.join(', ')}
									>
										{predefinedPlatforms.map((platform) => (
											<MenuItem key={platform} value={platform}>
												<Checkbox checked={selectedPlatforms.indexOf(platform) > -1} />
												<ListItemText primary={platform} />
											</MenuItem>
										))}
									</Select>
								</FormControl>
							) : property === 'image' ? (
								<div>
									<Button variant='outlined' onClick={handleUploadButtonClick}>
										Upload Image
									</Button>
									<input
										type='file'
										accept='image/*'
										id='imageInput'
										style={{ display: 'none' }}
										onChange={handleImageChange}
									/>
									{selectedImage && <div>Selected Image: {selectedImage.name}</div>}
								</div>
							) : property === 'mechanics' ? (
								<FormControl fullWidth margin='normal'>
									<InputLabel id='gameMechanics-label'>Game Mechanics</InputLabel>
									<Select label='Game Mechanics' value={selectedGameMechanics} onChange={handleGameMechanicsChange}>
										{predefinedGameMechanics.map((gameMechanics) => (
											<MenuItem key={gameMechanics} value={gameMechanics}>
												{gameMechanics}
											</MenuItem>
										))}
									</Select>
								</FormControl>
							) : property === 'universe' ? (
								<FormControl fullWidth margin='normal'>
									<InputLabel id='universeInfo-label'>Universe Info</InputLabel>
									<Select label='Universe Info' value={selectedUniverseInfo} onChange={handleUniverseInfoChange}>
										{predefinedUniverseInfo.map((universeInfo) => (
											<MenuItem key={universeInfo} value={universeInfo}>
												{universeInfo}
											</MenuItem>
										))}
									</Select>
								</FormControl>
							) : property === 'playerNumber' ? (
								<FormControl fullWidth margin='normal'>
									<InputLabel id='playerNumber-label'>Number of Players</InputLabel>
									<Select label='Number of Players' value={selectedPlayerNumber} onChange={handlePlayerNumberChange}>
										{predefinedPlayerNumber.map((playerNumber) => (
											<MenuItem key={playerNumber} value={playerNumber}>
												{playerNumber}
											</MenuItem>
										))}
									</Select>
								</FormControl>
							) : (
								<TextField
									label={property.charAt(0).toUpperCase() + property.slice(1)}
									required
									fullWidth
									margin='normal'
									value={value}
									onChange={(event) => handleChange(property, event.target.value)}
								/>
							)}
						</div>
					))}
				</DialogContent>
				<DialogActions>
					<Button onClick={handleClose}>Cancel</Button>
					<Button type='submit' onClick={handleSubmit(onSubmit)}>
						Create
					</Button>
				</DialogActions>
			</Dialog>
		</div>
	)
}
