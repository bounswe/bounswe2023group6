import React from 'react'
import 'tailwindcss/tailwind.css'

const Signup = () => {
	return (
		<div className='bg-gray-200 py-20'>
			<div className='max-w-md mx-auto bg-white rounded-lg overflow-hidden md:max-w-md'>
				<div className='md:flex'>
					<div className='w-full p-3 px-6 py-10'>
						<div className='w-full'>
							<h1 className='text-xl text-gray-700 font-semibold mb-2'>Create an account</h1>
							<form className='space-y-5'>
								<div>
									<label className='block mb-1 font-semibold text-gray-500'>Full name</label>
									<input
										className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
										type='text'
									/>
								</div>
								<div>
									<label className='block mb-1 font-semibold text-gray-500'>Email</label>
									<input
										className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
										type='email'
									/>
								</div>
								<div>
									<label className='block mb-1 font-semibold text-gray-500'>Password</label>
									<input
										className='w-full h-10 px-3 text-base placeholder-gray-600 border rounded-lg focus:shadow-outline'
										type='password'
									/>
								</div>
								<button className='w-full h-10 px-3 text-white transition-colors duration-150 bg-blue-600 rounded-lg focus:shadow-outline hover:bg-blue-700'>
									Sign up
								</button>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	)
}

export default Signup
