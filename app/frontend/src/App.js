import React from 'react'
import { Route, Routes, BrowserRouter } from 'react-router-dom'
import { ForgotPassword, Login, Signup } from './pages/Auth'

const App = () => (
	<BrowserRouter>
		<Routes>
			<Route path='/login' element={<Login />} />
			<Route path='/forgot-password' element={<ForgotPassword />} />
			<Route path='/signup' element={<Signup />} />
		</Routes>
	</BrowserRouter>
)

export default App
