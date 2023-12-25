import React from 'react'
import Tooltip from '@mui/material/Tooltip'

const TextWithAnnotation = ({ text, annotations }) => {
	const parts = []
	let lastIndex = 0

	annotations.forEach((annotation, index) => {
		const { startIndex, endIndex, value } = annotation

		// Text before the annotation
		parts.push(text.substring(lastIndex, startIndex))

		// Annotated text
		parts.push(
			<Tooltip key={index} title={value} arrow>
				<span className='underline cursor-pointer'>{text.substring(startIndex, endIndex)}</span>
			</Tooltip>
		)

		lastIndex = endIndex
	})

	// Remaining text after the last annotation
	parts.push(text.substring(lastIndex))

	return <div>{parts}</div>
}

export default TextWithAnnotation
