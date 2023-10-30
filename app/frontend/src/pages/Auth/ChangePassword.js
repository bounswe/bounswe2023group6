import React, { useState, useEffect } from 'react'
import { useNavigate, useSearchParams } from 'react-router-dom'
import 'tailwindcss/tailwind.css'

const ChangePassword = () => {
	const [newPassword, setNewPassword] = useState('')
	const [validatePassword, setValidatePassword] = useState('')
	const [isLoading, setIsLoading] = useState(false)
	const [error, setError] = useState(null)
	const [isSuccessful, setIsSuccessful] = useState(false)
	const navigate = useNavigate()
	const [searchParams] = useSearchParams()
	const token = searchParams.get('token') // Assume token is a query param

	const validMockToken = '123456' // Replace this with an actual valid token for your application

	useEffect(() => {
		if (isSuccessful) {
			const timer = setTimeout(() => {
				navigate('/') // Redirect to homepage
			}, 2000)
			return () => clearTimeout(timer)
		}
	}, [isSuccessful, navigate])

	const handleChangePassword = async (e) => {
		e.preventDefault()
		setIsLoading(true)
		setError(null)

		if (newPassword !== validatePassword) {
			setError('Passwords do not match')
			setIsLoading(false)
			return
		}

		try {
			// Simulate API call for changing password
			await new Promise((resolve, reject) => {
				setTimeout(() => {
					if (token === validMockToken && newPassword && validatePassword) {
						resolve()
					} else {
						reject(new Error('Invalid token or password'))
					}
				}, 2000)
			})

			setIsSuccessful(true)
		} catch (err) {
			setError(err.message)
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
							<h1 className='text-xl text-gray-700 font-semibold mb-2'>Change Password</h1>
							{isSuccessful ? (
								<div>
									<p className='text-green-500'>Password successfully changed. Redirecting to homepage...</p>
								</div>
							) : (
								<form onSubmit={handleChangePassword} className='space-y-5'>
									<div>
										<label className='block mb-1 font-semibold text-gray-500'>New Password</label>
										<input
											className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
											type='password'
											value={newPassword}
											onChange={(e) => setNewPassword(e.target.value)}
										/>
									</div>
									<div>
										<label className='block mb-1 font-semibold text-gray-500'>Validate New Password</label>
										<input
											className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
											type='password'
											value={validatePassword}
											onChange={(e) => setValidatePassword(e.target.value)}
										/>
									</div>
									{error && <p className='text-red-500'>{error}</p>}
									<button
										className='w-full h-10 px-3 text-white transition-colors duration-150 bg-blue-600 rounded-lg focus:shadow-outline hover:bg-blue-700'
										type='submit'
										disabled={isLoading}
									>
										{isLoading ? 'Changing password...' : 'Change Password'}
									</button>
								</form>
							)}
						</div>
					</div>
				</div>
			</div>
		</div>
	)
}

export default ChangePassword
