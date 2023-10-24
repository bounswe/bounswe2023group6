import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'

const root = ReactDOM.createRoot(document.getElementById('root'))

root.render(
	<React.StrictMode>
		<>
			{/* tailwind hello world */}
			<div className='flex h-0.25'>
				<div className='text-4xl font-bold text-center text-blue-600'>Hello World!</div>
			</div>
			{/* tailwind cool button that changes color on hover */}
			<div className='flex h-0.5'>
				<button className='px-12 py-2 font-bold text-white bg-blue-600 rounded hover:bg-green-800'>Click Me!</button>
			</div>
		</>
		<App />
	</React.StrictMode>
)
