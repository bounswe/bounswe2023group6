import React, { useState } from 'react'
import VisibilityIcon from '@mui/icons-material/Visibility'
import VisibilityOffIcon from '@mui/icons-material/VisibilityOff'
import { Container, TextField, Button, InputAdornment, IconButton, Link } from '@mui/material'
import { createTheme, ThemeProvider } from '@mui/material/styles'
import CssBaseline from '@mui/material/CssBaseline'
import Box from '@mui/material/Box'
import Typography from '@mui/material/Typography'
import Alert from '@mui/material/Alert'
import Grid from '@mui/material/Grid'
const LoginPage = () => {
	const [showPassword, setShowPassword] = useState(false)

	const handlePasswordVisibility = () => {
		setShowPassword(!showPassword)
	}
	const [isError, setError] = useState(null)

	const defaultTheme = createTheme()

	const handleSubmit = (event) => {
		event.preventDefault()
		const data = new FormData(event.currentTarget)
		//TODO
		if (data.get('email') === 'admin' && data.get('password') === 'admin') {
			setError(false)
		} else {
			setError(true)
		}
		console.log({
			email: data.get('email'),
			password: data.get('password')
		})
	}

	return (
		<ThemeProvider theme={defaultTheme}>
			<Container component='main' maxWidth='xs'>
				<CssBaseline />
				<Box
					sx={{
						marginTop: 20,
						display: 'flex',
						flexDirection: 'column',
						justifyContent: 'center',
						alignItems: 'center'
					}}
				>
					<Typography component='h1' variant='h5'>
						Sign in
					</Typography>

					<Container maxWidth='sm'>
						{isError && (
							<Alert variant='filled' severity='error' sx={{ mt: 1 }}>
								Username or password is wrong!
							</Alert>
						)}

						<Box component='form' onSubmit={handleSubmit} noValidate sx={{ mt: 1 }}>
							<TextField
								margin='normal'
								required
								fullWidth
								id='email'
								label='Email Address'
								name='email'
								autoComplete='email'
								autoFocus
							/>
							<TextField
								margin='normal'
								required
								fullWidth
								name='password'
								label='Password'
								type={showPassword ? 'text' : 'password'}
								id='password'
								autoComplete='current-password'
								InputProps={{
									endAdornment: (
										<InputAdornment position='end'>
											<IconButton onClick={handlePasswordVisibility}>
												{showPassword ? <VisibilityIcon /> : <VisibilityOffIcon />}
											</IconButton>
										</InputAdornment>
									)
								}}
							/>

							<Button type='submit' fullWidth variant='contained' sx={{ mt: 1, mb: 2 }}>
								Sign In
							</Button>
							<Grid container>
								<Grid item xs>
									<Link href='forgot-password' variant='body2'>
										Forgot password?
									</Link>
								</Grid>
								<Grid item>
									<Link href='#' variant='body2'>
										{"Don't have an account? Sign Up"}
									</Link>
								</Grid>
							</Grid>
						</Box>
					</Container>
				</Box>
			</Container>
		</ThemeProvider>
	)
}

export default LoginPage
