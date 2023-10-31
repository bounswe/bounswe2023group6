import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import 'tailwindcss/tailwind.css'

const Login = () => {
	const [email, setEmail] = useState('')
	const [password, setPassword] = useState('')
	const [isLoading, setIsLoading] = useState(false)
	const [error, setError] = useState(null)
	const navigate = useNavigate()

	const handleLogin = async (e) => {
		e.preventDefault()
		setIsLoading(true)
		setError(null)

		try {
			// Simulate API call for login
			await new Promise((resolve, reject) => {
				setTimeout(() => {
					if (email === 'user@example.com' && password === 'password') {
						resolve()
					} else {
						reject(new Error('Invalid credentials'))
					}
				}, 2000)
			})

			navigate('/') // Redirect to homepage
		} catch (err) {
			setError('Invalid credentials. Please try again.')
		} finally {
			setIsLoading(false)
		}
	}

	return (
		<div className='bg-gray-200 py-20'>
			<div className='max-w-md mx-auto bg-white rounded-lg overflow-hidden md:max-w-md'>
				<div className='md:flex'>
					<div className='w-full p-3 px-6 py-10'>
						<div className='w-full'>
							<h1 className='text-xl text-gray-700 font-semibold mb-2'>Log in to your account</h1>
							<form onSubmit={handleLogin} className='space-y-5'>
								<div>
									<label className='block mb-1 font-semibold text-gray-500'>Email</label>
									<input
										className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
										type='email'
										value={email}
										onChange={(e) => setEmail(e.target.value)}
									/>
								</div>
								<div>
									<label className='block mb-1 font-semibold text-gray-500'>Password</label>
									<input
										className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
										type='password'
										value={password}
										onChange={(e) => setPassword(e.target.value)}
									/>
								</div>
								{error && <p className='text-red-500'>{error}</p>}
								<button
									className='w-full h-10 px-3 text-white transition-colors duration-150 bg-blue-600 rounded-lg focus:shadow-outline hover:bg-blue-700'
									type='submit'
									disabled={isLoading}
								>
									{isLoading ? 'Logging in...' : 'Log in'}
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	)
}
// import VisibilityIcon from '@mui/icons-material/Visibility'
// import VisibilityOffIcon from '@mui/icons-material/VisibilityOff'
// import { Container, TextField, Button, InputAdornment, IconButton, Link } from '@mui/material'
// import { createTheme, ThemeProvider } from '@mui/material/styles'
// import CssBaseline from '@mui/material/CssBaseline'
// import Box from '@mui/material/Box'
// import Typography from '@mui/material/Typography'
// import Alert from '@mui/material/Alert'
// import Grid from '@mui/material/Grid'
// const LoginPage = () => {
// 	const [showPassword, setShowPassword] = useState(false)

// 	const handlePasswordVisibility = () => {
// 		setShowPassword(!showPassword)
// 	}
// 	const [isError, setError] = useState(null)

// 	const defaultTheme = createTheme()

// 	const handleSubmit = (event) => {
// 		event.preventDefault()
// 		const data = new FormData(event.currentTarget)
// 		//TODO
// 		if (data.get('email') === 'admin' && data.get('password') === 'admin') {
// 			setError(false)
// 		} else {
// 			setError(true)
// 		}
// 		console.log({
// 			email: data.get('email'),
// 			password: data.get('password')
// 		})
// 	}

// 	return (
// 		<ThemeProvider theme={defaultTheme}>
// 			<Container component='main' maxWidth='xs'>
// 				<CssBaseline />
// 				<Box
// 					sx={{
// 						marginTop: 20,
// 						display: 'flex',
// 						flexDirection: 'column',
// 						justifyContent: 'center',
// 						alignItems: 'center'
// 					}}
// 				>
// 					<Typography component='h1' variant='h5'>
// 						Sign in
// 					</Typography>

// 					<Container maxWidth='sm'>
// 						{isError && (
// 							<Alert variant='filled' severity='error' sx={{ mt: 1 }}>
// 								Username or password is wrong!
// 							</Alert>
// 						)}

// 						<Box component='form' onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
// 							<TextField
// 								margin='normal'
// 								required
// 								fullWidth
// 								id='email'
// 								label='Email Address'
// 								name='email'
// 								autoComplete='email'
// 								autoFocus
// 							/>
// 							<TextField
// 								margin='normal'
// 								required
// 								fullWidth
// 								name='password'
// 								label='Password'
// 								type={showPassword ? 'text' : 'password'}
// 								id='password'
// 								autoComplete='current-password'
// 								InputProps={{
// 									endAdornment: (
// 										<InputAdornment position='end'>
// 											<IconButton onClick={handlePasswordVisibility}>
// 												{showPassword ? <VisibilityIcon /> : <VisibilityOffIcon />}
// 											</IconButton>
// 										</InputAdornment>
// 									)
// 								}}
// 							/>

// 							<Button type='submit' fullWidth variant='contained' sx={{ mt: 1, mb: 2 }}>
// 								Sign In
// 							</Button>
// 							<Grid container>
// 								<Grid item xs>
// 									<Link href='forgot-password' variant='body2'>
// 										Forgot password?
// 									</Link>
// 								</Grid>
// 								<Grid item>
// 									<Link href='#' variant='body2'>
// 										{"Don't have an account? Sign Up"}
// 									</Link>
// 								</Grid>
// 							</Grid>
// 						</Box>
// 					</Container>
// 				</Box>
// 			</Container>
// 		</ThemeProvider>
// 	)
// }

export default Login
