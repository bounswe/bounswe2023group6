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
//import { postChar } from '../../services/gameService'

export default function CreateGame() {
	const api_url = process.env.REACT_APP_API_URL
	const { handleSubmit } = useForm()
	const [open, setOpen] = useState(false)
	const [gameData, setGameData] = useState({
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

	const handleUploadButtonClick = () => {
		// Programmatically trigger the file input
		document.getElementById('imageInput').click()
	}

	const predefinedGenres = ['Action', 'Adventure', 'Role-playing (RPG)', 'Simulation', 'Strategy', 'Sports', 'Horror']
	const predefinedPlatforms = ['PC', 'PlayStation', 'Xbox', 'Nintendo Switch', 'Mobile']

	const [selectedGenres, setSelectedGenres] = useState([])
	const [selectedPlatforms, setSelectedPlatforms] = useState([])

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
			image: selectedImage
		}
		// //	if (postData.characters.length != 0) {
		// 		postData.characters.forEach(async (character) => {
		// 			const { name, description } = character
		// 			const characterData = { name, description }
		// 			try {
		// 				await postChar(gameIdcharacterData)
		// 			} catch (error) {
		// 				console.log(error)
		// 			}
		// 		})
		// 	}
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
			axios.defaults.withCredentials = true
			const response = await axios.post(`${api_url}/game`, formDataToSend, {
				headers: {
					'Content-Type': 'multipart/form-data'
				}
			})

			if (response.status === 201) {
				console.log('Game created successfully!')
			}
		} catch (error) {
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
			<Button variant='outlined' onClick={handleClickOpen}
            			 sx={{ color: 'white', backgroundColor: '#b46161', border: 'none', boxShadow: '0 2px 4px rgba(0, 0, 0, 0.4)', '&:hover': { backgroundColor: '#6e4141', border: 'none'} }}>
            				Create Game
            			</Button>
			<Dialog open={open} onClose={handleClose} fullWidth>
				<DialogTitle>
					Create Game
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
							) : property === 'characters' ? (
								<>
									{gameData.characters.map((character, index) => (
										<div key={`character-${index}`}>
											<TextField
												label={`Character ${index + 1} Name`}
												fullWidth
												margin='normal'
												value={character.name}
												onChange={(event) => {
													const updatedCharacters = [...gameData.characters]
													updatedCharacters[index].name = event.target.value
													setGameData((prevData) => ({ ...prevData, characters: updatedCharacters }))
												}}
											/>
											<TextField
												label={`Character ${index + 1} Description`}
												fullWidth
												margin='normal'
												value={character.description}
												onChange={(event) => {
													const updatedCharacters = [...gameData.characters]
													updatedCharacters[index].description = event.target.value
													setGameData((prevData) => ({ ...prevData, characters: updatedCharacters }))
												}}
											/>
										</div>
									))}
								</>
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
