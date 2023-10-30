import React from 'react'
import '../../index.css'
import logo from './images/logo.png'
import './ForgotPassword.css'
const ForgotPassword = () => (
	<div id='container' style={{ fontFamily: 'Jost, sans-serif' }}>
		<div
			style={{
				display: 'flex',
				flexDirection: 'column',
				alignItems: 'center',
				height: '100vh'
			}}
		>
			<header
				style={{
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center',
					width: '100%',
					height: '18%',
					backgroundColor: '#B46060',
					borderBottom: '3px solid #B46060',
					boxShadow: '0px 8px 4px rgba(0,0,0,0.6)'
				}}
			>
				<img src={logo} alt='Game Lounge' style={{ maxHeight: '90%', maxWidth: '200px' }} />
			</header>
			<main
				style={{
					flexGrow: 1,
					display: 'flex',
					justifyContent: 'center',
					alignItems: 'center'
				}}
			>
				<div className='cover'></div>
				<form
					style={{
						backgroundColor: '#4D4D4Dee',
						boxShadow: '0px 4px 15px rgba(0,0,0,0.8)'
					}}
				>
					<h1 style={{ color: '#FFF4E0', fontSize: '1.4rem' }}>Forgot Password</h1>
					<h2 style={{ color: '#FFF4E0', fontSize: '1rem' }}>
						If the email you enter matches an account, we will send a reset code to:
					</h2>

					<input
						id='input-email'
						type='email'
						placeholder='Enter your email'
						style={{
							borderRadius: '3px',
							outline: 'none',
							fontSize: '1rem',
							boxShadow: '0px 4px 15px rgba(0,0,0,0.6)'
						}}
					/>
					<div id='btn-container'>
						<button
							type='submit'
							style={{
								backgroundColor: '#FFBF9B',
								color: '#B46060',
								border: 'none',
								borderRadius: '3px',
								cursor: 'pointer',
								fontSize: '1rem',
								fontWeight: 600,
								boxShadow: '0px 4px 15px rgba(0,0,0,0.6)'
							}}
						>
							Reset Password
						</button>
					</div>
				</form>
			</main>
		</div>
	</div>
)

export default ForgotPassword
