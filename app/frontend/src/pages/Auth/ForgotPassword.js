import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import 'tailwindcss/tailwind.css';
import axios from 'axios';
import logo from './images/logo.png';

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
		<div id='container' style={{ fontFamily: 'Jost, sans-serif', backgroundColor: '#B46060' }}>
			<header
				style={{
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center',
					backgroundColor: '#B46060',
					borderBottom: '3px solid #B46060',
					boxShadow: '0px 8px 4px rgba(0,0,0,0.6)'
				}}
			>
				<img src={logo} alt='Game Lounge' style={{ maxHeight: '90%', maxWidth: '200px' }} />
			</header>
			<div className='bg-gray-200 py-20' style={{ flexGrow: 1, display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
				<div
					className='max-w-md mx-auto bg-white rounded-lg overflow-hidden md:max-w-md'
					style={{ backgroundColor: '#4D4D4Dee', boxShadow: '0px 4px 15px rgba(0,0,0,0.8)' }}
				>
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
										<h1 style={{ color: '#FFF4E0', fontSize: '1.4rem' }}>Forgot Password</h1>
										<div>
											<label htmlFor='username' className='block text-sm font-medium text-blue-500'>
												Username
											</label>
											<input
												type='text'
												id='username'
												name='username'
												value={username}
												onChange={(e) => setUsername(e.target.value)}
												className='mt-1 p-2 w-full border rounded-md'
												style={{
													borderRadius: '3px',
													outline: 'none',
													fontSize: '1rem',
													boxShadow: '0px 4px 15px rgba(0,0,0,0.6)'
												}}
											/>
										</div>
										<div>
											<label htmlFor='email' className='block text-sm font-medium text-blue-500'>
												Email
											</label>
											<input
												type='email'
												id='email'
												name='email'
												value={email}
												onChange={(e) => setEmail(e.target.value)}
												className='mt-1 p-2 w-full border rounded-md'
												style={{
													borderRadius: '3px',
													outline: 'none',
													fontSize: '1rem',
													boxShadow: '0px 4px 15px rgba(0,0,0,0.6)'
												}}
											/>
										</div>
										{error && <p className='text-red-500'>{error}</p>}
										<button
											type='submit'
											className='w-full bg-blue-500 text-white p-2 rounded-md'
											style={{
												backgroundColor: '#FFBF9B',
												color: '#B46060',
												boxShadow: '0px 4px 15px rgba(0,0,0,0.6)'
											}}
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
		</div>
	);
}

export default ForgotPassword;