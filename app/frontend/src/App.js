import React from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom'
import { HomePage } from './pages/HomePage'
import { GamePage } from './pages/GamePage'
import { ResetPassword, ForgotPassword, Login, Signup } from './pages/Auth'
import { NextUIProvider } from '@nextui-org/react'

const App = () => (
	<NextUIProvider disableBaseline='true'>
		<BrowserRouter>
			<Routes>
				<Route exact path='/' element={<HomePage />} />
				<Route path='/login' element={<Login />} />
				<Route path='/forgot-password' element={<ForgotPassword />} />
				<Route path='/signup' element={<Signup />} />
				<Route path='/reset-password' element={<ResetPassword />} />
				<Route path='/home' element={<HomePage />} />
				<Route path='/game/fifa' element={<GamePage />} />
			</Routes>
		</BrowserRouter>
	</NextUIProvider>
)

export default App
