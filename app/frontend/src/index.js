import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
import 'primereact/resources/themes/lara-light-indigo/theme.css' // theme
import 'primereact/resources/primereact.css' // core css
import 'primeicons/primeicons.css' // icons

const root = ReactDOM.createRoot(document.getElementById('root'))

root.render(
	<React.StrictMode>
		<>{/* tailwind hello world */}</>
		<App />
	</React.StrictMode>
)
