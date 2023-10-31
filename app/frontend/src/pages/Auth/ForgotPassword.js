import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import 'tailwindcss/tailwind.css';
import axios from 'axios';
// import logo from './images/logo.png';
// import { useNavigate } from 'react-router-dom';
// import 'path/to/your/css/file.css'; // Import your CSS file

const ForgotPassword = () => {
	const [isSubmitted, setIsSubmitted] = useState(false);
	const [username, setUsername] = useState('');
	const [email, setEmail] = useState('');
	const [isLoading, setIsLoading] = useState(false);
	const [error, setError] = useState(null);

	const handleSubmit = async (event) => {
		event.preventDefault();

		setIsLoading(true);
		setError(null);

		const data = {
			username,
			email
		};

		try {
			const response = await axios.post('http://167.99.242.175:8080/forgot-password', data, {
				headers: {
					'Content-Type': 'application/json'
				}
			});

			if (response.status === 200) {
				setIsSubmitted(true);
			}
		} catch (e) {
			setError('An error occurred. Please try again.');
		} finally {
			setIsLoading(false);
		}
	};

	return (
		<div className='bg-gray-200 py-20' style={{ flexGrow: 1, display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
			<div
				className='max-w-md mx-auto bg-white rounded-lg overflow-hidden md:max-w-md'
			>
				<div className='md:flex'>
					<div className='w-full p-3 px-6 py-10'>
						<div className='w-full'>
							{isSubmitted ? (
								<div>
									<h1 className='text-xl text-slate-900 font-semibold mb-2'>Reset link sent!</h1>
									<p className='text-gray-600'>Please check your email for a link to reset your password.</p>
								</div>
							) : (
								<form onSubmit={handleSubmit} className='space-y-5'>
									<h1 className='text-xl text-slate-900 font-semibold mb-2'>Forgot Password</h1>
									<div>
										<label htmlFor='username' className='block text-sm font-medium text-slate-600'>
											Username
										</label>
										<input
											type='text'
											id='username'
											name='username'
											value={username}
											onChange={(e) => setUsername(e.target.value)}
											className='mt-1 p-2 w-full border rounded-md font-medium text-lg'
										/>
									</div>
									<div>
										<label htmlFor='email' className='block text-sm font-medium text-slate-600'>
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
									<button
										type='submit'
                                    	className='w-full h-10 px-3 text-white transition-colors duration-150 bg-blue-600 rounded-lg focus:shadow-outline hover:bg-blue-700'
										disabled={isLoading}
									>
										{isLoading ? 'Loading...' : 'Send Reset Link'}
									</button>
								</form>
							)}
							<div className='mt-4 text-right'>
								<Link to='/login' className='text-blue-500 hover:underline'>
									Back to Sign In
								</Link>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	);
}

export default ForgotPassword;