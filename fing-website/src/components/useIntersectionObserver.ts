import React from 'react'
import { useState, useEffect, MutableRefObject } from "react";

export const useIntersectionObserver = (target: MutableRefObject<null>, className: string) => {
    const [animated, setAnimated] = useState(false)

    const onIntersect: IntersectionObserverCallback = async ([{ isIntersecting, target }], observer) => {
        if (isIntersecting) {
            observer.unobserve(target)

            target.classList.add(className)

            setAnimated(true)
        }
    }
    
    useEffect(() => {
        if (animated) return
        let observer: IntersectionObserver
        if (target.current) {
            observer = new IntersectionObserver(onIntersect)

            observer.observe(target.current)
        }

        return () => observer && observer.disconnect()
    })
}
