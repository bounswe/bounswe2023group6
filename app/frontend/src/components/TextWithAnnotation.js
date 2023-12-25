import React from 'react'
import Tooltip from '@mui/material/Tooltip'

const TextWithAnnotation = ({ text, annotations }) => {
	const parts = []
	let lastIndex = 0

	const sortedAnnotations = annotations.sort((a, b) => a.startIndex - b.startIndex)

	sortedAnnotations.forEach((annotation, index) => {
		const { startIndex, endIndex, value } = annotation
		console.log(annotation, index)

		parts.push(text.substring(lastIndex, startIndex))

		parts.push(
			<Tooltip key={index} title={value} arrow>
				<span className='underline cursor-pointer'>{text.substring(startIndex, endIndex)}</span>
			</Tooltip>
		)

		lastIndex = endIndex
	})

	parts.push(text.substring(lastIndex))

	return <div>{parts}</div>
}

export default TextWithAnnotation
