import React, { useState } from 'react'
import 'tailwindcss/tailwind.css'

const ForgotPassword = () => {
	const [isSubmitted, setIsSubmitted] = useState(false)
	const [email, setEmail] = useState('')
	const [isLoading, setIsLoading] = useState(false)
	const [error, setError] = useState(null)

	const handleSubmit = async (event) => {
		event.preventDefault()
		if (!email) {
			setError('Email is required')
			return
		}

		setIsLoading(true)
		setError(null)

		try {
			// Simulate API call
			await new Promise((resolve) => setTimeout(resolve, 2000))
			setIsSubmitted(true)
		} catch (e) {
			setError('An error occurred. Please try again.')
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
							{isSubmitted ? (
								<div>
									<h1 className='text-xl text-gray-700 font-semibold mb-2'>Reset link sent!</h1>
									<p className='text-gray-500'>Please check your email for a link to reset your password.</p>
								</div>
							) : (
								<form onSubmit={handleSubmit} className='space-y-5'>
									<div>
										<label htmlFor='email' className='block text-sm font-medium text-gray-600'>
											Email
										</label>
										<input
											type='email'
											id='email'
											name='email'
											value={email}
											onChange={(e) => setEmail(e.target.value)}
											className='mt-1 p-2 w-full border rounded-md'
										/>
									</div>
									{error && <p className='text-red-500'>{error}</p>}
									<button type='submit' className='w-full bg-blue-500 text-white p-2 rounded-md' disabled={isLoading}>
										{isLoading ? 'Loading...' : 'Send Reset Link'}
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

export default ForgotPassword
